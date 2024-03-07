import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum SSOType {
  google,
  facebook,
  apple;

  Color get background {
    switch(this) {
      case SSOType.google:
        return Colors.white;
      case SSOType.facebook:
        return const Color(0xFF4267B2);
      case SSOType.apple:
        return const Color(0xFF000000);
    }
  }

  SvgGenImage get icon  {
    switch(this) {
      case SSOType.google:
        return MyAssets.googleIcon;
      case SSOType.facebook:
        return MyAssets.facebookIcon;
      case SSOType.apple:
        return MyAssets.facebookIcon;
    }
  }
}