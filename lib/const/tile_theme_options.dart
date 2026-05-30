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
        2: Color(0xFFFFE1EF),
        4: Color(0xFFFFC6E0),
        8: Color(0xFFFFD166),
        16: Color(0xFFFF9F6E),
        32: Color(0xFF8FE3CF),
        64: Color(0xFF57C7FF),
        128: Color(0xFFB693FF),
        256: Color(0xFFFF7AB8),
        512: Color(0xFFFF5C8A),
        1024: Color(0xFF7C5CFF),
        2048: Color(0xFFFFC857),
      },
    ),
    TileThemeOption(
      id: 'bubblegum',
      labelKey: LocaleKeys.tile_theme_bubblegum,
      colors: {
        2: Color(0xFFFFEFF8),
        4: Color(0xFFFFD8EE),
        8: Color(0xFFFFB3D9),
        16: Color(0xFFFF8FC8),
        32: Color(0xFFFF6BB6),
        64: Color(0xFFFF479F),
        128: Color(0xFFFFC2E2),
        256: Color(0xFFE879F9),
        512: Color(0xFFC084FC),
        1024: Color(0xFFA78BFA),
        2048: Color(0xFFFACC15),
      },
    ),
    TileThemeOption(
      id: 'rainbow',
      labelKey: LocaleKeys.tile_theme_rainbow,
      colors: {
        2: Color(0xFFFFADAD),
        4: Color(0xFFFFD6A5),
        8: Color(0xFFFDFFB6),
        16: Color(0xFFCAFFBF),
        32: Color(0xFF9BF6FF),
        64: Color(0xFFA0C4FF),
        128: Color(0xFFBDB2FF),
        256: Color(0xFFFFC6FF),
        512: Color(0xFFFF7EB6),
        1024: Color(0xFFFF8A5B),
        2048: Color(0xFFFFD166),
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
