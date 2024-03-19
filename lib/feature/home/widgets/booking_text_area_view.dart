import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/feature/home/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BookingTextAreaView extends StatelessWidget {
  final ServiceDetails detail;
  const BookingTextAreaView({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(children: [
            Container(),
            Flexible(
              child: Text(
                detail.textEn ?? '',
                style: context.textTheme.labelLarge,
                maxLines: 2,
              ),
            )
          ]),
          const Gap(16),
          AppTextField(hintText: detail.textEn ?? '', maxLine: 3,)
        ],
      ),
    );
  }
}
