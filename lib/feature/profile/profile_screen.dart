import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/theme/app_colors.dart';
import 'package:borigarn/feature/profile/types/settings_menu_type.dart';
import 'package:borigarn/feature/profile/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menu = [
      SettingMenuType.editProfile,
      SettingMenuType.paymentMethod,
      SettingMenuType.myPlace,
      SettingMenuType.language,
      SettingMenuType.invite,
      SettingMenuType.feedback,
      SettingMenuType.termAndCondition,
      SettingMenuType.privacy,
      SettingMenuType.paymentAndRefund,
      SettingMenuType.deleteUser,
      SettingMenuType.logout,
    ];

    return Scaffold(
      appBar: const ProfileAppBar(),
      body: RefreshIndicator(
        onRefresh: () async => ({

        }),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Divider(height: 1, thickness: 1, color: context.appColors.border),
            itemCount: menu.length,
            itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {

                switch (menu[index]) {
                  case SettingMenuType.editProfile:
                    context.pushNamed('edit_profile_screen');
                  case SettingMenuType.paymentMethod:
                    context.pushNamed('help-center');
                  case SettingMenuType.myPlace:
                    context.pushNamed('location');
                  case SettingMenuType.language:
                    context.pushNamed('app-version');
                  case SettingMenuType.invite:
                    context.pushNamed('app-version');
                  default:
                    context.pushNamed('app-version');
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Padding(
                  padding: EdgeInsets.only(top: menu[index] == SettingMenuType.logout ? 20 : 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      menu[index].getIcon().svg(width: 20, height: 20),
                      const Gap(8),
                      Text(
                        menu[index].getTitle(),
                        style: context.textTheme.bodyMedium?.apply(color: menu[index].getTextColor()),
                      ),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Icon(Symbols.chevron_right,color: context.appColors.subTitle, )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
