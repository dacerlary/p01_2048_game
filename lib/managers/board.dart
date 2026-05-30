import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/tile.dart';
import '../models/board.dart';
import '../models/game_direction.dart';

import 'next_direction.dart';
import 'round.dart';
import 'score_history.dart';

class BoardManager extends ChangeNotifier {
  final verticalOrder = [12, 8, 4, 0, 13, 9, 5, 1, 14, 10, 6, 2, 15, 11, 7, 3];

  final RoundManager roundManager;
  final NextDirectionManager nextDirectionManager;
  final ScoreHistoryManager scoreHistoryManager;
  Board _state = Board.newGame(0, []);
  bool _hasSavedCurrentScore = false;

  BoardManager(
    this.roundManager,
    this.nextDirectionManager,
    this.scoreHistoryManager,
  ) {
    load();
  }

  Board get state => _state;

  set state(Board value) {
    _state = value;
    notifyListeners();
  }

  void load() async {
    var box = await Hive.openBox<Board>('boardBox');
    state = box.get(0) ?? _newGame();
    _hasSavedCurrentScore = state.over && state.score > 0;
  }

  int maxScore() {
    return state.score > state.best ? state.score : state.best;
  }

  Board _newGame() {
    return Board.newGame(maxScore(), [random([])]);
  }

  void newGame() {
    _saveCurrentScoreToHistory();
    state = _newGame();
    _hasSavedCurrentScore = false;
  }

  bool _inRange(index, nextIndex) {
    return index < 4 && nextIndex < 4 ||
        index >= 4 && index < 8 && nextIndex >= 4 && nextIndex < 8 ||
        index >= 8 && index < 12 && nextIndex >= 8 && nextIndex < 12 ||
        index >= 12 && nextIndex >= 12;
  }

  Tile _calculate(Tile tile, List<Tile> tiles, direction) {
    bool asc = direction == GameDirection.left || direction == GameDirection.up;
    bool vert =
        direction == GameDirection.up || direction == GameDirection.down;
    int index = vert ? verticalOrder[tile.index] : tile.index;
    int nextIndex = ((index + 1) / 4).ceil() * 4 - (asc ? 4 : 1);

    if (tiles.isNotEmpty) {
      var last = tiles.last;
      var lastIndex = last.nextIndex ?? last.index;
      lastIndex = vert ? verticalOrder[lastIndex] : lastIndex;
      if (_inRange(index, lastIndex)) {
        nextIndex = lastIndex + (asc ? 1 : -1);
      }
    }

    return tile.copyWith(
      nextIndex: vert ? verticalOrder.indexOf(nextIndex) : nextIndex,
    );
  }

  bool move(GameDirection direction) {
    if (state.over) {
      return false;
    }

    bool asc = direction == GameDirection.left || direction == GameDirection.up;
    bool vert =
        direction == GameDirection.up || direction == GameDirection.down;
    final sortedTiles = [...state.tiles]
      ..sort(
        ((a, b) =>
            (asc ? 1 : -1) *
            (vert
                ? verticalOrder[a.index].compareTo(verticalOrder[b.index])
                : a.index.compareTo(b.index))),
      );

    List<Tile> tiles = [];
    var hasChanged = false;

    for (int i = 0, l = sortedTiles.length; i < l; i++) {
      var tile = sortedTiles[i];

      tile = _calculate(tile, tiles, direction);
      if (tile.nextIndex != null && tile.nextIndex != tile.index) {
        hasChanged = true;
      }
      tiles.add(tile);

      if (i + 1 < l) {
        var next = sortedTiles[i + 1];
        if (tile.value == next.value) {
          var index = vert ? verticalOrder[tile.index] : tile.index,
              nextIndex = vert ? verticalOrder[next.index] : next.index;
          if (_inRange(index, nextIndex)) {
            tiles.add(next.copyWith(nextIndex: tile.nextIndex));
            hasChanged = true;
            i += 1;
            continue;
          }
        }
      }
    }

    if (!hasChanged) {
      return false;
    }

    state = state.copyWith(tiles: tiles, undo: state);
    return true;
  }

  Tile random(List<int> indexes) {
    var i = 0;
    var rng = Random();
    do {
      i = rng.nextInt(16);
    } while (indexes.contains(i));

    return Tile(const Uuid().v4(), 2, i);
  }

  void merge() {
    List<Tile> tiles = [];
    var tilesMoved = false;
    List<int> indexes = [];
    var score = state.score;

    for (int i = 0, l = state.tiles.length; i < l; i++) {
      var tile = state.tiles[i];

      var value = tile.value, merged = false;

      if (i + 1 < l) {
        var next = state.tiles[i + 1];
        if (tile.nextIndex == next.nextIndex ||
            tile.index == next.nextIndex && tile.nextIndex == null) {
          value = tile.value + next.value;
          merged = true;
          score += value;
          i += 1;
        }
      }

      if (merged || tile.nextIndex != null && tile.index != tile.nextIndex) {
        tilesMoved = true;
      }

      tiles.add(
        tile.copyWith(
          index: tile.nextIndex ?? tile.index,
          nextIndex: null,
          value: value,
          merged: merged,
        ),
      );
      indexes.add(tiles.last.index);
    }

    if (tilesMoved) {
      tiles.add(random(indexes));
    }
    state = state.copyWith(score: score, tiles: tiles);
  }

  void _endRound() {
    var gameOver = true, gameWon = false;
    List<Tile> tiles = [];

    if (state.tiles.length == 16) {
      state.tiles.sort(((a, b) => a.index.compareTo(b.index)));

      for (int i = 0, l = state.tiles.length; i < l; i++) {
        var tile = state.tiles[i];

        if (tile.value == 2048) {
          gameWon = true;
        }

        var x = (i - (((i + 1) / 4).ceil() * 4 - 4));

        if (x > 0 && i - 1 >= 0) {
          var left = state.tiles[i - 1];
          if (tile.value == left.value) {
            gameOver = false;
          }
        }

        if (x < 3 && i + 1 < l) {
          var right = state.tiles[i + 1];
          if (tile.value == right.value) {
            gameOver = false;
          }
        }

        if (i - 4 >= 0) {
          var top = state.tiles[i - 4];
          if (tile.value == top.value) {
            gameOver = false;
          }
        }

        if (i + 4 < l) {
          var bottom = state.tiles[i + 4];
          if (tile.value == bottom.value) {
            gameOver = false;
          }
        }
        tiles.add(tile.copyWith(merged: false));
      }
    } else {
      gameOver = false;
      for (var tile in state.tiles) {
        if (tile.value == 2048) {
          gameWon = true;
        }
        tiles.add(tile.copyWith(merged: false));
      }
    }

    state = state.copyWith(
      tiles: tiles,
      won: gameWon,
      over: gameOver || gameWon,
    );
    if (gameOver || gameWon) {
      _saveCurrentScoreToHistory();
    }
  }

  bool endRound() {
    _endRound();
    roundManager.end();

    var nextDirection = nextDirectionManager.state;
    if (nextDirection != null) {
      final moved = move(nextDirection);
      nextDirectionManager.clear();
      return moved;
    }
    return false;
  }

  void undo() {
    if (state.undo != null) {
      state = state.copyWith(
        score: state.undo!.score,
        best: state.undo!.best,
        tiles: state.undo!.tiles,
      );
    }
  }

  bool onKey(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return false;
    }

    GameDirection? direction;
    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      direction = GameDirection.right;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      direction = GameDirection.left;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      direction = GameDirection.up;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      direction = GameDirection.down;
    }

    if (direction != null) {
      return move(direction);
    }
    return false;
  }

  void save() async {
    var box = await Hive.openBox<Board>('boardBox');
    try {
      box.putAt(0, state);
    } catch (e) {
      box.add(state);
    }
  }

  void _saveCurrentScoreToHistory() {
    if (_hasSavedCurrentScore || state.score <= 0) {
      return;
    }
    _hasSavedCurrentScore = true;
    scoreHistoryManager.addScore(state.score);
  }
}
