import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../types/action_navigation_type.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isCenterTitle;
  final bool isShowBorder;
  final List<ActionNavigationType> leftNavigation;
  final List<ActionNavigationType> rightNavigation;
  Function(ActionNavigationType)? callback;

  MainAppBar(
      {super.key,
        required this.title,
        this.leftNavigation = const [ActionNavigationType.navigationBack],
        this.rightNavigation = const [],
        this.isCenterTitle = false,
        this.isShowBorder = true,
        this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: !isShowBorder
          ? null
          : BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: context.appColors.border,
          ),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: isCenterTitle,
        leading:leftNavigation.isNotEmpty ? IconButton(
          icon: leftNavigation.first.getIcon(),
          onPressed: () {
            if (leftNavigation.first == ActionNavigationType.navigationBack) {
              Navigator.of(context).pop();
            } else {
              callback?.call(leftNavigation.first);
            }
          },
        ) : null,
        title: Text(
          title,
          style: context.textTheme.labelLarge?.apply(color: Colors.black),
        ),
        actions: [
          ...rightNavigation.map((element) {
            switch (element) {
              case ActionNavigationType.activeDelete:
              case ActionNavigationType.inactiveDelete:
              case ActionNavigationType.searchIcon:
              case ActionNavigationType.booking:
                return IconButton(
                    icon: element.getIcon(),
                    onPressed: () {
                      if (element != ActionNavigationType.inactiveDelete) {
                        callback?.call(element);
                      }
                    });
              case ActionNavigationType.loading:
                return const SizedBox.shrink();
              default:
                return const SizedBox.shrink();
            }
          })
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(58);
}
