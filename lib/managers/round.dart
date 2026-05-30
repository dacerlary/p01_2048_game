import 'package:flutter/foundation.dart';

class RoundManager extends ChangeNotifier {
  bool _state = true;

  bool get state => _state;

  set state(bool value) {
    if (_state == value) return;
    _state = value;
    notifyListeners();
  }

  void end() {
    state = true;
  }

  void begin() {
    state = false;
  }
}
