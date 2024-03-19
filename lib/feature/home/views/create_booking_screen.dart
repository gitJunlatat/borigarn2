import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/types/action_navigation_type.dart';
import 'package:borigarn/core/utils/wrap_sliver.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:borigarn/feature/home/types/select_form_type.dart';
import 'package:borigarn/feature/home/types/service_type.dart';
import 'package:borigarn/feature/home/widgets/booking_choice_view.dart';
import 'package:borigarn/feature/home/widgets/booking_text_area_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateBookingScreen extends ConsumerWidget {
  final Service model;

  const CreateBookingScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: context.appColors.light,
        appBar: MainAppBar(
          title: model.nameEn ?? '',
          isCenterTitle: true,
          isShowBorder: true,
          rightNavigation: const [ActionNavigationType.info],
          callback: (type) {
            if(type == ActionNavigationType.info) {
              context.pushNamed('booking_info');
            }
          },
        ),
        body: CustomScrollView(
          slivers: [
            const Gap(20).wrapSliver(),
            SliverList(delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final details = model.details ?? [];

                switch (details[index].getFormType()) {
                  case SelectFormType.choice:
                    return BookingChoiceView(detail: details[index]);
                  case SelectFormType.multiChoice:
                    return BookingChoiceView(detail: details[index]);
                  case SelectFormType.dateTime:
                  return const SizedBox.shrink();
                  case SelectFormType.freeText:
                    return BookingTextAreaView(detail: details[index]);
                  default:
                    return SizedBox.shrink();
                }
              },
              childCount: model.details?.length ?? 0,
            ))

          ],
        ));
  }
}
