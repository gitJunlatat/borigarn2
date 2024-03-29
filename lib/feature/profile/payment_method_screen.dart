import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/shimmer_list_loading.dart';
import 'package:borigarn/feature/profile/types/settings_menu_type.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: context.appColors.light,
        appBar: MainAppBar(
          title: SettingMenuType.paymentMethod.getTitle(),
          isCenterTitle: true,
          isShowBorder: false,
        ),
        body: SafeArea(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return const ShimmerListLoading(count: 4,);
            },
          ),
        ));
  }
}
