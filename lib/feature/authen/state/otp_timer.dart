import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'otp_timer.g.dart';

@riverpod
class OtpTimer extends _$OtpTimer {
  @override
  int build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    ref.listenSelf((previous, next) {
      if (next == 60) {
        startTimer();
      }
    });
    return 60;
  }

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    final endTime = DateTime.now().add(const Duration(seconds: 61));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      state = endTime.difference(now).inSeconds;
      if (state <= 0) {
        _timer?.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}