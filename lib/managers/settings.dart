import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../const/background_options.dart';
import '../const/tile_theme_options.dart';

class SettingsManager extends ChangeNotifier {
  static const _boxName = 'settingsBox';
  static const _backgroundKey = 'boardBackground';
  static const _tileThemeKey = 'tileTheme';

  bool _isLoading = true;
  String _backgroundId = GameBackgroundOptions.defaultId;
  String _tileThemeId = TileThemeOptions.defaultId;

  SettingsManager() {
    load();
  }

  bool get isLoading => _isLoading;
  String get backgroundId => _backgroundId;
  GameBackgroundOption get background =>
      GameBackgroundOptions.byId(_backgroundId);
  String get tileThemeId => _tileThemeId;
  TileThemeOption get tileTheme => TileThemeOptions.byId(_tileThemeId);

  Future<void> load() async {
    final box = await Hive.openBox(_boxName);
    _backgroundId =
        box.get(_backgroundKey, defaultValue: GameBackgroundOptions.defaultId)
            as String;
    _tileThemeId =
        box.get(_tileThemeKey, defaultValue: TileThemeOptions.defaultId)
            as String;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setBackground(String id) async {
    if (_backgroundId == id) return;

    final box = await Hive.openBox(_boxName);
    await box.put(_backgroundKey, id);
    _backgroundId = id;
    notifyListeners();
  }

  Future<void> setTileTheme(String id) async {
    if (_tileThemeId == id) return;

    final box = await Hive.openBox(_boxName);
    await box.put(_tileThemeKey, id);
    _tileThemeId = id;
    notifyListeners();
  }
}
