import 'package:flutter/foundation.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class NextDirectionManager extends ChangeNotifier {
  SwipeDirection? _state;

  SwipeDirection? get state => _state;

  set state(SwipeDirection? value) {
    if (_state == value) return;
    _state = value;
    notifyListeners();
  }

  void queue(SwipeDirection direction) {
    state = direction;
  }

  void clear() {
    state = null;
  }
}
