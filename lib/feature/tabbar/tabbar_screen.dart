import 'dart:async';

import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/feature/tabbar/types/tabbar_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabBarScreen extends StatefulHookConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const TabBarScreen(
      this.navigationShell, {
        super.key,
      });

  @override
  ConsumerState<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends ConsumerState<TabBarScreen> {
  StreamSubscription? _sub;
  bool isShowHomeBannerDialog = true;



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<TabBarType> tabBarTypes = [TabBarType.home, TabBarType.booking, TabBarType.inbox, TabBarType.profile];
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.navigationShell,
      bottomNavigationBar: HookBuilder(builder: (context) {
        final tabState = useState(0);
        return BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 15,
            selectedFontSize: 7,
            unselectedFontSize: 7,
            currentIndex: widget.navigationShell.currentIndex,
            selectedItemColor: context.appColors.primary,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              tabState.value = index;
              widget.navigationShell.goBranch(
                tabState.value,
                initialLocation: true,
              );
            },
            selectedLabelStyle: context.textTheme.bodySmall,
            unselectedLabelStyle: context.textTheme.bodySmall,
            items: tabBarTypes
                .map((type) => BottomNavigationBarItem(
                icon: type.getIcon(widget.navigationShell.currentIndex == type.index),
                label: type.getName()))
                .toList());
      }),
    );
  }
}
