import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
  }
}

class Throttler {
  final Duration delay;
  Timer? _timer;
  bool _isThrottled = false;

  Throttler({required this.delay});

  void call(void Function() callback) {
    if (!_isThrottled) {
      callback();
      _isThrottled = true;

      _timer = Timer(delay, () {
        _isThrottled = false;
      });
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}