import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/feature/home/state/get_user.dart';
import 'package:borigarn/feature/profile/types/settings_menu_type.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendScreen extends ConsumerWidget {
  const InviteFriendScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refCode = ref.read(getUserProvider).valueOrNull?.referralCode ?? '';
    return Container(
      color: context.appColors.light,
      child: SafeArea(
        child: Scaffold(
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: ButtonWidget(
                  text: context.tr(LocaleKeys.inviteFriendButton),
                  onPressed: () async {
                    final result = await Share.shareWithResult("เลขรหัสแนะนำคือ ${refCode}");
                    if (result.status == ShareResultStatus.success) {
                      print('Thank you for sharing my website!');
                    }
                  },
                  backgroundColor: context.appColors.primary,
                  textColor: Colors.white,
                )),
            backgroundColor: context.appColors.light,
            appBar: MainAppBar(
              title: SettingMenuType.invite.getTitle(),
              isCenterTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INVITE FRIENDS',
                      style: context.textTheme.titleMedium?.apply(color: Colors.black),
                    ),
                    const Gap(16),
                    Flexible(
                      child: Text(
                        "Invite people you know to join Borigarn - for every person who completes their first booking, you'll Coins get up to ฿50 .",
                        style: context.textTheme.bodyLarge?.apply(color: context.appColors.title),
                      ),
                    ),
                    const Gap(16),
                    Divider(
                      height: 1,
                      color: context.appColors.border,
                    ),
                    const Gap(16),
                    Text(
                      'HOW DO INVITES WORK?',
                      style: context.textTheme.titleMedium?.apply(color: Colors.black),
                    ),
                    const Gap(16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyAssets.iconShare.svg(width: 32, height: 32),
                        const Gap(20),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Share your link',
                                style: context.textTheme.bodyLarge?.apply(color: Colors.black),
                              ),
                              const Gap(4),
                              Flexible(
                                child: Text(
                                  'Invite friends to join Borigarn using your unique link.',
                                  style: context.textTheme.bodyMedium?.apply(color: context.appColors.title),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyAssets.iconGive.svg(width: 32, height: 32),
                        const Gap(20),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Give ฿50',
                                style: context.textTheme.bodyLarge?.apply(color: Colors.black),
                              ),
                              const Gap(4),
                              Flexible(
                                child: Text(
                                  'Friends who sign up for Borigarn with your link will get Coins ฿50 for their booking.',
                                  style: context.textTheme.bodyMedium?.apply(color: context.appColors.title),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyAssets.iconCoin.svg(width: 32, height: 32),
                        const Gap(20),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Get ฿50',
                                style: context.textTheme.bodyLarge?.apply(color: Colors.black),
                              ),
                              const Gap(4),
                              Flexible(
                                child: Text(
                                  maxLines: 10,
                                  "When your friend completes a first-time booking, you'll get Coins up to ฿50 .",
                                  overflow: TextOverflow.visible,
                                  style: context.textTheme.bodyMedium?.apply(color: context.appColors.title),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
