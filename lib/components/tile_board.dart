import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/board_layout.dart';
import '../const/colors.dart';
import '../managers/board.dart';
import '../managers/settings.dart';
import '../resource/resource.dart';

import 'animated_tile.dart';
import 'button.dart';

class TileBoardWidget extends StatelessWidget {
  const TileBoardWidget({
    super.key,
    required this.moveAnimation,
    required this.scaleAnimation,
  });

  final CurvedAnimation moveAnimation;
  final CurvedAnimation scaleAnimation;

  @override
  Widget build(BuildContext context) {
    final board = context.watch<BoardManager>().state;
    final tileTheme = context.watch<SettingsManager>().tileTheme;

    final size = max(
      290.0,
      min(
        (MediaQuery.of(context).size.shortestSide * 0.90).floorToDouble(),
        460.0,
      ),
    );

    const gap = BoardLayout.gap;
    final sizePerTile = (size / 4).floorToDouble();
    final tileSize = sizePerTile - gap - (gap / 4);
    final boardSize = sizePerTile * 4;
    return SizedBox(
      width: boardSize,
      height: boardSize,
      child: Stack(
        children: [
          ...List.generate(board.tiles.length, (i) {
            var tile = board.tiles[i];
            final tileColor =
                tileTheme.colors[tile.value] ??
                colorApp.tileColors[tile.value] ??
                colorApp.tile2048;
            final textColor = _textColorForTile(tileColor);

            return AnimatedTile(
              key: ValueKey(tile.id),
              tile: tile,
              moveAnimation: moveAnimation,
              scaleAnimation: scaleAnimation,
              size: tileSize,
              child: Container(
                width: tileSize,
                height: tileSize,
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: colorApp.text.withValues(alpha: 0.18),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: colorApp.textWhite.withValues(alpha: 0.82),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${tile.value}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: tile.value < 1000 ? 30.0 : 24.0,
                      color: textColor,
                      shadows: [
                        Shadow(
                          color: textColor == colorApp.text
                              ? colorApp.textWhite.withValues(alpha: 0.42)
                              : colorApp.text.withValues(alpha: 0.28),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          if (board.over)
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.86, end: 1),
                duration: const Duration(milliseconds: 360),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(scale: value, child: child);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colorApp.overlay,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 86,
                        height: 86,
                        decoration: BoxDecoration(
                          color: colorApp.accent,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: colorApp.button.withValues(alpha: 0.28),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          board.won ? Icons.emoji_events : Icons.replay,
                          color: colorApp.textWhite,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        board.won
                            ? LocaleKeys.you_win.tr()
                            : LocaleKeys.game_over.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorApp.text,
                          fontWeight: FontWeight.w900,
                          fontSize: 38.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        LocaleKeys.final_score.tr(args: ['${board.score}']),
                        style: TextStyle(
                          color: colorApp.text,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ButtonWidget(
                        text: LocaleKeys.try_again.tr(),
                        onPressed: () {
                          context.read<BoardManager>().newGame();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _textColorForTile(Color tileColor) {
    return tileColor.computeLuminance() > 0.48
        ? colorApp.text
        : colorApp.textWhite;
  }
}
