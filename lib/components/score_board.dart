import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../managers/board.dart';
import '../resource/resource.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final score = context.select<BoardManager, int>(
      (manager) => manager.state.score,
    );
    final best = context.select<BoardManager, int>(
      (manager) => manager.state.best,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Score(label: LocaleKeys.score.tr(), score: '$score'),
        const SizedBox(width: 8.0),
        Score(
          label: LocaleKeys.best.tr(),
          score: '$best',
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ],
    );
  }
}

class Score extends StatelessWidget {
  const Score({
    Key? key,
    required this.label,
    required this.score,
    this.padding,
  }) : super(key: key);

  final String label;
  final String score;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: colorApp.score,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colorApp.textWhite, width: 2),
        boxShadow: [
          BoxShadow(
            color: colorApp.score.withValues(alpha: 0.28),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 18.0,
              color: colorApp.scoreLabel,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            score,
            style: TextStyle(
              color: colorApp.textWhite,
              fontWeight: FontWeight.w900,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
