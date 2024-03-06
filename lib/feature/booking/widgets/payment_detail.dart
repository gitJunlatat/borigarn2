import 'package:borigarn/feature/booking/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PaymentDetail extends StatelessWidget {
  final String price;

  const PaymentDetail({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Subtotal',
            style: context.textTheme.bodySmall?.apply(color: Colors.black),
          ),
          Text(
            '฿$price',
            style: context.textTheme.bodySmall?.apply(color: Colors.black),
          )
        ],
      ),
      const Gap(16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Discount',
            style: context.textTheme.bodySmall?.apply(color: Colors.black),
          ),
          Text(
            '฿0',
            style: context.textTheme.bodySmall?.apply(color: Colors.black),
          )
        ],
      ),
      const Gap(16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TOTAL',
            style: context.textTheme.labelMedium?.apply(color: Colors.black),
          ),
          Text(
            '฿$price',
            style: context.textTheme.labelMedium?.apply(color: Colors.black),
          )
        ],
      ),
    ]);
  }
}
