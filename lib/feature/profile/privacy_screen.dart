import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/feature/profile/types/settings_menu_type.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  final SettingMenuType type;
  const PrivacyScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: context.appColors.light,appBar: MainAppBar(title: type.getTitle(), isCenterTitle: true,), body: Text(''));
  }
}
