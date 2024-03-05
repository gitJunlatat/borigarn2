import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;
  const MainAppbar({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: context.appColors.primary,
          size: 24,
        ),
        onPressed: onPressed ?? () => context.pop(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
