import 'package:flutter/material.dart';

import '../resource/resource.dart';

class TileThemeOption {
  const TileThemeOption({
    required this.id,
    required this.labelKey,
    required this.colors,
  });

  final String id;
  final String labelKey;
  final Map<int, Color> colors;
}

class TileThemeOptions {
  const TileThemeOptions._();

  static const defaultId = 'sweet';

  static const values = <TileThemeOption>[
    TileThemeOption(
      id: defaultId,
      labelKey: LocaleKeys.tile_theme_sweet,
      colors: {
        2: Color(0xFFFFD1E6),
        4: Color(0xFFFFA3C7),
        8: Color(0xFFFFC400),
        16: Color(0xFFFF7A00),
        32: Color(0xFF00BFA5),
        64: Color(0xFF0091EA),
        128: Color(0xFF7C4DFF),
        256: Color(0xFFD4145A),
        512: Color(0xFFC2185B),
        1024: Color(0xFF512DA8),
        2048: Color(0xFFFFA000),
      },
    ),
    TileThemeOption(
      id: 'bubblegum',
      labelKey: LocaleKeys.tile_theme_bubblegum,
      colors: {
        2: Color(0xFFFFD6EA),
        4: Color(0xFFFF9BC7),
        8: Color(0xFFFF5FA2),
        16: Color(0xFFE91E63),
        32: Color(0xFFC2185B),
        64: Color(0xFFAD1457),
        128: Color(0xFFAB47BC),
        256: Color(0xFF8E24AA),
        512: Color(0xFF6A1B9A),
        1024: Color(0xFF4A148C),
        2048: Color(0xFFFFB300),
      },
    ),
    TileThemeOption(
      id: 'rainbow',
      labelKey: LocaleKeys.tile_theme_rainbow,
      colors: {
        2: Color(0xFFFF5252),
        4: Color(0xFFFF9100),
        8: Color(0xFFFFD600),
        16: Color(0xFF00C853),
        32: Color(0xFF00B8D4),
        64: Color(0xFF2979FF),
        128: Color(0xFF651FFF),
        256: Color(0xFFD500F9),
        512: Color(0xFFFF4081),
        1024: Color(0xFFDD2C00),
        2048: Color(0xFFFFAB00),
      },
    ),
  ];

  static TileThemeOption byId(String id) {
    return values.firstWhere(
      (option) => option.id == id,
      orElse: () => values.first,
    );
  }
}
