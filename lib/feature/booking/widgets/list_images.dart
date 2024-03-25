import 'dart:io';

import 'package:borigarn/core/widgets/app_image_network.dart';
import 'package:borigarn/core/widgets/app_media_screen.dart';
import 'package:borigarn/core/widgets/app_photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListImages extends StatelessWidget {
  final Widget? addWidget;
  final List<String> images;
  final bool isLocalImage;

  const ListImages({super.key, required this.images, required this.isLocalImage, this.addWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: isLocalImage ? 0 : 24),
      height: 120.h,
      width: 1.sw,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: (addWidget != null) ? images.length + 1 : images.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0 && addWidget != null) {
            return Padding(padding: const EdgeInsets.only(left: 16), child: addWidget);
          }
          final image = images[(addWidget != null) ? index - 1 : index];

          final isLast = ((addWidget != null) ? index - 1 : index) == images.length - 1;
          return Padding(
            padding: EdgeInsets.only(right: isLast ? 16 : 0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MediaViewScreen(
                      medias: images,
                      initialPage: ((addWidget != null) ? index - 1 : index),
                      isLocalImage: isLocalImage,
                    ),
                  ),
                );
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: (isLocalImage)
                      ? Image.file(
                          File(image),
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                        )
                      : AppImageNetwork(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          width: 120.w,
                          height: 120.h,
                        )),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(indent: 10, color: Colors.transparent);
        },
      ),
    );
  }
}
