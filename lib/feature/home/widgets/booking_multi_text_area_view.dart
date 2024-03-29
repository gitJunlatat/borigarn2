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

class BookingMultiTextAreaView extends HookConsumerWidget {
  final ServiceDetails detail;
  const BookingMultiTextAreaView({super.key, required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textController1 = TextEditingController();
    textController1.text = detail.result1 ?? '';
    textController1.selection = TextSelection.fromPosition(TextPosition(offset: textController1.text.length));

    final textController2 = TextEditingController();
    textController2.text = detail.result2 ?? '';
    textController2.selection = TextSelection.fromPosition(TextPosition(offset: textController2.text.length));

    final textController3 = TextEditingController();
    textController3.text = detail.result3 ?? '';
    textController3.selection = TextSelection.fromPosition(TextPosition(offset: textController3.text.length));

    final textController4 = TextEditingController();
    textController4.text = detail.result4 ?? '';
    textController4.selection = TextSelection.fromPosition(TextPosition(offset: textController4.text.length));

    final locale = ref.watch(getLocaleProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 16,top: 16,right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHighlightView(width: 5, wording: detail.getText(locale) ?? ''),
          const Gap(16),
          ListView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemBuilder: (BuildContext context, int index) {
            final item = detail.items![index];
            TextEditingController controller;
            switch(index) {
              case 0:
                controller = textController1;
              case 1:
                controller = textController2;
              case 2:
                controller = textController3;
              case 3:
                controller = textController4;
              default:
                controller = textController4;
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(hintText: item.getName(locale) ?? '', controller: controller, maxLine: 1, onChanged: (text) {
                    EasyDebounce.debounce(
                        'debouncer',                 // <-- An ID for this particular debouncer
                        const Duration(milliseconds: 500),    // <-- The debounce duration
                            ()  {
                          switch(index) {
                            case 0:
                              detail.result1 = (text.isEmpty) ? null : text;
                              ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);
                            case 1:
                              detail.result2 = (text.isEmpty) ? null : text;
                              ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);
                            case 2:
                              detail.result3 = (text.isEmpty) ? null : text;
                              ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);
                            case 3:
                              detail.result4 = (text.isEmpty) ? null : text;
                              ref.read(bookingPayloadProvider.notifier).updatePayloadDetail(detail);
                            default:
                          }
                        }
                    );

                  })
                ],
              ),
            );
          }, itemCount: detail.items?.length ?? 0,)
        ],

      ),
    );
  }
}
