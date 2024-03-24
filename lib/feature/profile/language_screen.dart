import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/state/get_locale.dart';
import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LanguageScreen extends HookConsumerWidget {
   const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = useState<String>(context.locale.languageCode);
    final items = [LanguageType.en, LanguageType.th];
    return Container(
      color: context.appColors.light,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(bottom: 20, top: 10, left: 16, right: 16),
            child: ButtonWidget(
              onPressed: () {
                context.pop();
              },
              text: context.tr('save'),
              height: 50,
              radius: 12,
              backgroundColor: context.appColors.primary,
              textColor: Colors.white,
            ),
          ),
          backgroundColor: context.appColors.light,
          appBar: MainAppBar(
            title: context.tr('language'),
            isCenterTitle: true,
            isShowBorder: false,
          ),
          body: ListView.separated(itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            final isSelected = currentLocale.value == item.name;
            return InkWell(
              onTap: () {
                if(!isSelected) {
                  context.setLocale(Locale(item.name));
                  ref.read(getLocaleProvider.notifier).setLocal(item.name);
                  currentLocale.value = item.name;
                }
              },
              child: Column(
                children:[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        item.icon.image(width: 24, height: 24, fit: BoxFit.cover),
                        const Gap(12),
                        Expanded(child: Text(item.title, style: isSelected ? context.textTheme.bodyLarge?.apply(color: context.appColors.primary) : context.textTheme.bodyMedium?.apply(color: Colors.black),)),
                        if(isSelected)
                          MyAssets.checkIcon.svg(width: 24.w, height: 24.h)
                      ],
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 16),child: Container(height: 1, width: 1.sw, color: context.appColors.border,))
                ] ,
              ),
            );
          },
              separatorBuilder: (context, index) =>  Gap(1),
              itemCount: items.length),
        ),
      ),
    );
  }
}
