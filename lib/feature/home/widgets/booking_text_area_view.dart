import 'package:borigarn/core/state/get_locale.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/feature/home/models/service_detail.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:borigarn/feature/home/state/booking_payload.dart';
import 'package:borigarn/feature/profile/widgets/title_hilight_view.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/manager/network.dart';

class BookingTextAreaView extends HookConsumerWidget {
  final ServiceDetails detail;
  const BookingTextAreaView({super.key, required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textController = TextEditingController();
    textController.text = detail.result ?? '';
    textController.selection = TextSelection.fromPosition(TextPosition(offset: textController.text.length));

    final locale = ref.watch(getLocaleProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHighlightView(width: 5, wording: detail.getText(locale) ?? ''),
          const Gap(16),
          AppTextField(hintText: detail.getText(locale) ?? '', controller: textController, maxLine: 3, onChanged: (text) {
            detail.result = (text.isEmpty) ? null : text;
            EasyDebounce.debounce(
                'debouncer',                 // <-- An ID for this particular debouncer
                const Duration(milliseconds: 500),    // <-- The debounce duration
                    () => ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail)             // <-- The target method
            );

          })
        ],
      ),
    );
  }
}
