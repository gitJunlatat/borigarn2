import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/radio_list_tile.dart';
import 'package:flutter/material.dart';

class GroupRadio extends StatelessWidget {
  final String selected;
  final List<String> data;
  final Function onChanged;

  const GroupRadio(
      {super.key,
        required this.data,
        required this.onChanged,
        required this.selected});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: data.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return RadioListTileWidget(
          onChanged: onChanged,
          value: data[index],
          groupValue: selected,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          text: data[index],
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 0,
        color: Colors.white,
      ),
    );
  }
}
