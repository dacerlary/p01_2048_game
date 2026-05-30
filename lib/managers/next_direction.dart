import 'package:flutter/foundation.dart';

import '../models/game_direction.dart';

class NextDirectionManager extends ChangeNotifier {
  GameDirection? _state;

  GameDirection? get state => _state;

  set state(GameDirection? value) {
    if (_state == value) return;
    _state = value;
    notifyListeners();
  }

  void queue(GameDirection direction) {
    state = direction;
  }

  void clear() {
    state = null;
  }
}
