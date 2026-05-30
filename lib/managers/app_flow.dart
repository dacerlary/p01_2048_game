import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppFlowManager extends ChangeNotifier {
  static const _boxName = 'appSettingsBox';
  static const _onboardingSeenKey = 'onboardingSeen';

  bool _isLoading = true;
  bool _hasSeenOnboarding = false;

  AppFlowManager() {
    load();
  }

  bool get isLoading => _isLoading;
  bool get hasSeenOnboarding => _hasSeenOnboarding;

  Future<void> load() async {
    final box = await Hive.openBox(_boxName);
    _hasSeenOnboarding =
        box.get(_onboardingSeenKey, defaultValue: false) as bool;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> finishOnboarding() async {
    final box = await Hive.openBox(_boxName);
    await box.put(_onboardingSeenKey, true);
    _hasSeenOnboarding = true;
    notifyListeners();
  }
}
