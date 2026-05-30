import 'package:flutter/material.dart';

final colorApp = ColorApp();

class ColorApp {
  Color get background => const Color(0xFFFFEEF7);
  Color get surface => const Color(0xFFFFFFFF);
  Color get text => const Color(0xFF241428);
  Color get textWhite => const Color(0xFFFFFFFF);
  Color get board => const Color(0xFFE91E63);
  Color get emptyTile => const Color(0xFFFFB8D6);
  Color get button => const Color(0xFFD4145A);
  Color get score => const Color(0xFF7B1FA2);
  Color get scoreLabel => const Color(0xFFFFD9EA);
  Color get overlay => const Color(0xF7FFF0F7);
  Color get accent => const Color(0xFFFFB300);
  Color get mint => const Color(0xFF00A884);
  Color get sky => const Color(0xFF0277BD);

  Color get tile2 => const Color(0xFFFFD1E6);
  Color get tile4 => const Color(0xFFFFA3C7);
  Color get tile8 => const Color(0xFFFFC400);
  Color get tile16 => const Color(0xFFFF7A00);
  Color get tile32 => const Color(0xFF00BFA5);
  Color get tile64 => const Color(0xFF0091EA);
  Color get tile128 => const Color(0xFF7C4DFF);
  Color get tile256 => const Color(0xFFD4145A);
  Color get tile512 => const Color(0xFFC2185B);
  Color get tile1024 => const Color(0xFF512DA8);
  Color get tile2048 => const Color(0xFFFFA000);

  Map<int, Color> get tileColors => {
    2: tile2,
    4: tile4,
    8: tile8,
    16: tile16,
    32: tile32,
    64: tile64,
    128: tile128,
    256: tile256,
    512: tile512,
    1024: tile1024,
    2048: tile2048,
  };
}
