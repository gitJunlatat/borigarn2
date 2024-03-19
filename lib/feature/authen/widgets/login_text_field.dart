import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/feature/authen/type/login_form_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginTextField extends StatelessWidget {
  final LoginFormType sectionType;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const LoginTextField({
    super.key,
    required this.sectionType,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    switch (sectionType) {
      case LoginFormType.username:
        return AppTextField(
          controller: controller,
          focusNode: focusNode,
          hintText: sectionType.getHintTextFieldName(),
          textInputAction: TextInputAction.next,
        );
      case LoginFormType.password:
        return HookBuilder(builder: (context) {
          final hidePassword = useState<bool>(true);
          return AppTextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: hidePassword.value,
            hintText: sectionType.getHintTextFieldName(),
            suffixIcon: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => hidePassword.value = !hidePassword.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 15,
                ),
                child: Icon(
                  hidePassword.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 14,
                  color: context.appColors.black,
                ),
              ),
            ),
          );
        });
    }
  }
}
