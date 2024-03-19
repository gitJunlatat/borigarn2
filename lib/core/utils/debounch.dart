import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  Timer? timer;
  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    /*   if (timer != null) {
      timer?.cancel();
    } */
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
