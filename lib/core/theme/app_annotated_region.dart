import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppAnnotatedRegion extends StatelessWidget {
  const AppAnnotatedRegion({
    super.key,
    required this.child,
    this.systemUiOverlayStyle = const AppSystemUiOverlayStyle.light(),
  });

  const AppAnnotatedRegion.light({
    super.key,
    required this.child,
    this.systemUiOverlayStyle = const AppSystemUiOverlayStyle.light(),
  });

  const AppAnnotatedRegion.dark({
    super.key,
    required this.child,
    this.systemUiOverlayStyle = const AppSystemUiOverlayStyle.dark(),
  });

  final Widget child;

  final SystemUiOverlayStyle systemUiOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: child,
    );
  }
}

class AppSystemUiOverlayStyle extends SystemUiOverlayStyle {
  const AppSystemUiOverlayStyle.light({
    super.statusBarBrightness = Brightness.dark,
    super.statusBarIconBrightness = Brightness.light,
  });

  const AppSystemUiOverlayStyle.dark({
    super.statusBarBrightness = Brightness.light,
    super.statusBarIconBrightness = Brightness.dark,
  });
}
