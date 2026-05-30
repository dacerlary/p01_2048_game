import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/score_history_entry.dart';

class ScoreHistoryManager extends ChangeNotifier {
  static const _boxName = 'scoreHistoryBox';

  final List<ScoreHistoryEntry> _entries = [];
  bool _isLoading = true;

  ScoreHistoryManager() {
    load();
  }

  List<ScoreHistoryEntry> get entries => List.unmodifiable(_entries);
  bool get isLoading => _isLoading;

  Future<Box> get _box => Hive.openBox(_boxName);

  Future<void> load() async {
    final box = await _box;
    _entries
      ..clear()
      ..addAll(
          box.values.whereType<Map>().map(ScoreHistoryEntry.fromMap).toList()
            ..sort((a, b) {
              final scoreCompare = b.score.compareTo(a.score);
              if (scoreCompare != 0) return scoreCompare;
              return b.playedAt.compareTo(a.playedAt);
            }));
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addScore(int score) async {
    if (score <= 0) return;

    final entry = ScoreHistoryEntry(
      id: const Uuid().v4(),
      score: score,
      playedAt: DateTime.now(),
    );
    final box = await _box;
    await box.put(entry.id, entry.toMap());
    _entries.add(entry);
    _entries.sort((a, b) {
      final scoreCompare = b.score.compareTo(a.score);
      if (scoreCompare != 0) return scoreCompare;
      return b.playedAt.compareTo(a.playedAt);
    });
    notifyListeners();
  }

  Future<void> deleteMany(Set<String> ids) async {
    if (ids.isEmpty) return;

    final box = await _box;
    await box.deleteAll(ids);
    _entries.removeWhere((entry) => ids.contains(entry.id));
    notifyListeners();
  }

  Future<void> clearAll() async {
    final box = await _box;
    await box.clear();
    _entries.clear();
    notifyListeners();
  }
}
