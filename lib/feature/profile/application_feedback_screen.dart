import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/feature/profile/types/settings_menu_type.dart';
import 'package:borigarn/feature/profile/widgets/title_hilight_view.dart';
import 'package:borigarn/global/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ApplicationFeedbackScreen extends HookConsumerWidget {
  const ApplicationFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackController = useTextEditingController();
    return Container(
      color: context.appColors.light,
      child: SafeArea(
        child: Scaffold(backgroundColor: context.appColors.light,
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: ButtonWidget(
                  text: context.tr(LocaleKeys.sendFeedBack),
                  onPressed: () {

                  },
                  backgroundColor: context.appColors.primary,
                  textColor: Colors.white,
                )),
            appBar: MainAppBar(title: SettingMenuType.feedback.getTitle(), isCenterTitle: true,),
            body:   SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TitleHighlightView(width: 5, wording: context.tr(LocaleKeys.titleFeedback)),
                    const Gap(20),
                    Text(style: context.textTheme.bodyLarge?.apply(color: context.appColors.title), context.tr(LocaleKeys.detailFeedback)),
                    const Gap(20),
                    AppTextField(hintText: context.tr(LocaleKeys.yourFeedback),maxLine: 5, controller: feedbackController,)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
