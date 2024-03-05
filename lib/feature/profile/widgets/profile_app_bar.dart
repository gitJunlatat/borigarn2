import 'package:borigarn/core/widgets/app_image_network.dart';
import 'package:borigarn/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userNotifierProvider);
    return Container(
      height: 110 + MediaQuery.of(context).padding.top,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MyAssets.profileBg.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        ''
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(139);
}

// class ProfileAppBarLoadingState extends StatelessWidget {
//   const ProfileAppBarLoadingState({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(
//       child: Row(
//         children: [
//           SkeletonCircle(radius: size32),
//           Gap(12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   Skeleton(
//                     borderRadius: size16,
//                     height: 21,
//                     width: 90,
//                   ),
//                   Gap(size16),
//                   Skeleton(
//                     borderRadius: size16,
//                     height: 21,
//                     width: 90,
//                   ),
//                 ],
//               ),
//               Gap(4),
//               Skeleton(
//                 borderRadius: size16,
//                 height: size16,
//                 width: 129,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
