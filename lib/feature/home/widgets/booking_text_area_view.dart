import 'package:borigarn/core/state/get_locale.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/feature/home/models/service_detail.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:borigarn/feature/home/state/booking_payload.dart';
import 'package:borigarn/feature/profile/widgets/title_hilight_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/manager/network.dart';

class BookingTextAreaView extends ConsumerWidget {
  final ServiceDetails detail;
  const BookingTextAreaView({super.key, required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(getLocaleProvider);
    // final textController = TextEditingController();
    // final FocusNode focusNode = FocusNode();

    // focusNode.addListener(() {
    //   log.d("TOTOasdsadasdT ${focusNode.hasFocus}");
    //   if(!focusNode.hasFocus) {
    //     detail.result = textController.text;
    //     log.d("TOTOT");
    //     log.e(detail.result);
    //     ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);
    //   }
    // });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHighlightView(width: 5, wording: detail.getText(locale) ?? ''),
          const Gap(16),
          AppTextField(hintText: detail.getText(locale) ?? '', maxLine: 3, onChanged: (text) {
            detail.result = (text.isEmpty) ? null : text;
            ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);
          })
        ],
      ),
    );
  }
}
