import 'package:flutter/material.dart';

import 'colors.dart';
import '../resource/resource.dart';
import 'app_images.dart';

class GameBackgroundOption {
  const GameBackgroundOption.color({
    required this.id,
    required this.labelKey,
    required this.color,
  }) : imageAsset = null;

  const GameBackgroundOption.image({
    required this.id,
    required this.labelKey,
    required this.imageAsset,
  }) : color = null;

  final String id;
  final String labelKey;
  final Color? color;
  final String? imageAsset;

  bool get isImage => imageAsset != null;
}

class GameBackgroundOptions {
  const GameBackgroundOptions._();

  static const defaultId = 'mint';

  static final values = <GameBackgroundOption>[
    GameBackgroundOption.color(
      id: defaultId,
      labelKey: LocaleKeys.background_mint,
      color: colorApp.background,
    ),
    const GameBackgroundOption.color(
      id: 'cream',
      labelKey: LocaleKeys.background_cream,
      color: Color(0xFFFFF7ED),
    ),
    const GameBackgroundOption.color(
      id: 'sky',
      labelKey: LocaleKeys.background_sky,
      color: Color(0xFFE0F2FE),
    ),
    const GameBackgroundOption.color(
      id: 'rose',
      labelKey: LocaleKeys.background_rose,
      color: Color(0xFFFFE4E6),
    ),
    const GameBackgroundOption.image(
      id: 'candy',
      labelKey: LocaleKeys.background_candy,
      imageAsset: AppImages.backgroundCandy,
    ),
    const GameBackgroundOption.image(
      id: 'clouds',
      labelKey: LocaleKeys.background_clouds,
      imageAsset: AppImages.backgroundClouds,
    ),
    const GameBackgroundOption.image(
      id: 'balloons',
      labelKey: LocaleKeys.background_balloons,
      imageAsset: AppImages.backgroundBalloons,
    ),
  ];

  static GameBackgroundOption byId(String id) {
    return values.firstWhere(
      (option) => option.id == id,
      orElse: () => values.first,
    );
  }
}
