import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:flutter/material.dart';

class SwitchView extends StatefulWidget {
  bool value;
  final ValueChanged<bool> onChanged;
  // Callback function
  SwitchView({super.key, required this.value, required this.onChanged});

  @override
  State<SwitchView> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchView> {

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
    MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return context.appColors.primary;
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
    MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        // Material color when switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.amber.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );

    return Switch(
      // This bool value toggles the switch.
      value: widget.value,
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          widget.onChanged(value);
          widget.value = value;
        });
      },
    );
  }
}
