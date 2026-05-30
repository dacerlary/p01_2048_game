import 'package:flutter/material.dart';

final colorApp = ColorApp();

class ColorApp {
  Color get background => const Color(0xFFFFF7FB);
  Color get surface => const Color(0xFFFFFFFF);
  Color get text => const Color(0xFF40263A);
  Color get textWhite => const Color(0xFFFFFFFF);
  Color get board => const Color(0xFFFF8FBD);
  Color get emptyTile => const Color(0xFFFFD6E8);
  Color get button => const Color(0xFFFF5CA8);
  Color get score => const Color(0xFFFF7AB8);
  Color get scoreLabel => const Color(0xFFFFF0F7);
  Color get overlay => const Color(0xEFFFF7FB);
  Color get accent => const Color(0xFFFFC857);
  Color get mint => const Color(0xFF75E6D1);
  Color get sky => const Color(0xFF8FD3FF);

  Color get tile2 => const Color(0xFFFFE1EF);
  Color get tile4 => const Color(0xFFFFC6E0);
  Color get tile8 => const Color(0xFFFFD166);
  Color get tile16 => const Color(0xFFFF9F6E);
  Color get tile32 => const Color(0xFF8FE3CF);
  Color get tile64 => const Color(0xFF57C7FF);
  Color get tile128 => const Color(0xFFB693FF);
  Color get tile256 => const Color(0xFFFF7AB8);
  Color get tile512 => const Color(0xFFFF5C8A);
  Color get tile1024 => const Color(0xFF7C5CFF);
  Color get tile2048 => const Color(0xFFFFC857);

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
