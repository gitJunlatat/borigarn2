import 'package:borigarn/core/theme/app_color_extension.dart';
import 'package:borigarn/core/widgets/AppTextField.dart';
import 'package:borigarn/core/widgets/ButtonWidget.dart';
import 'package:borigarn/core/widgets/main_app_bar.dart';
import 'package:borigarn/core/widgets/main_card.dart';
import 'package:borigarn/core/widgets/shimmer_list_loading.dart';
import 'package:borigarn/feature/home/state/get_user.dart';
import 'package:borigarn/feature/profile/controller/profile_controller.dart';
import 'package:borigarn/feature/profile/types/edit_form_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final phoneNumberController = useTextEditingController();
    final emailController = useTextEditingController();

    return ref.watch(getUserProvider).when(data: (data) {
      usernameController.text = data.name ?? '';
      phoneNumberController.text = data.phone ?? '';
      emailController.text = data.email ?? '';

      return Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 20, top: 10, left: 16, right: 16),
          child: ButtonWidget(
            onPressed: () {

              ref.read(profileControllerProvider).saveProfile(usernameController.text, emailController.text);
            },
            text: 'SAVE',
            height: 50,
            radius: 12,
            backgroundColor: context.appColors.primary,
            textColor: Colors.white,
          ),
        ),
        backgroundColor: context.appColors.light,
        appBar: MainAppBar(
          title: 'Edit Profile',
          isCenterTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EditFormType.name.title,
                  style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                ),
                const Gap(8),
                AppTextField(
                  hintText: EditFormType.name.title,
                  controller: usernameController,
                  prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: EditFormType.name.icon.svg(width: 16, height: 16)),
                ),
                const Gap(20),
                Text(
                  EditFormType.phoneNumber.title,
                  style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                ),
                const Gap(8),
                AppTextField(
                    hintText: EditFormType.phoneNumber.title,
                    controller: phoneNumberController,
                    prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: EditFormType.phoneNumber.icon.svg(width: 16, height: 16))),
                const Gap(20),
                Text(
                  EditFormType.email.title,
                  style: context.textTheme.bodyMedium?.apply(color: Colors.black),
                ),
                const Gap(8),
                AppTextField(
                    hintText: EditFormType.email.title,
                    controller: emailController,
                    prefixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: EditFormType.email.icon.svg(width: 16, height: 16)))
              ],
            ),
          ),
        ),
      );
    }, error: (error, stack) {
      return Scaffold(
        backgroundColor: context.appColors.light,
        body: const ShimmerListLoading(
          count: 3,
        ),
        appBar: MainAppBar(
          title: 'Edit Profile',
          isCenterTitle: true,
        ),
      );
    }, loading: () {
      return Scaffold(
        backgroundColor: context.appColors.light,
        body: const ShimmerListLoading(
          count: 3,
        ),
        appBar: MainAppBar(
          title: 'Edit Profile',
          isCenterTitle: true,
        ),
      );
    });
  }
}
