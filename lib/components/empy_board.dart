import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../managers/settings.dart';

class EmptyBoardWidget extends StatelessWidget {
  const EmptyBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final background = context.watch<SettingsManager>().background;
    final size = max(
      290.0,
      min(
        (MediaQuery.of(context).size.shortestSide * 0.90).floorToDouble(),
        460.0,
      ),
    );

    final sizePerTile = (size / 4).floorToDouble();
    final tileSize = sizePerTile - 12.0 - (12.0 / 4);
    final boardSize = sizePerTile * 4;
    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
        color: background.color ?? colorApp.board,
        image: background.imageUrl == null
            ? null
            : DecorationImage(
                image: NetworkImage(background.imageUrl!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  colorApp.board.withValues(alpha: 0.18),
                  BlendMode.lighten,
                ),
              ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: colorApp.button.withValues(alpha: 0.24),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: List.generate(16, (i) {
          var x = ((i + 1) / 4).ceil();
          var y = x - 1;

          var top = y * (tileSize) + (x * 12.0);
          var z = (i - (4 * y));
          var left = z * (tileSize) + ((z + 1) * 12.0);

          return Positioned(
            top: top,
            left: left,
            child: Container(
              width: tileSize,
              height: tileSize,
              decoration: BoxDecoration(
                color: background.imageUrl == null
                    ? colorApp.emptyTile
                    : colorApp.textWhite.withValues(alpha: 0.78),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          );
        }),
      ),
    );
  }
}
