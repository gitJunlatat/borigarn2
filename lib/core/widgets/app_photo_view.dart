import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'empty_view.dart';

class AppPhotoView extends StatelessWidget {
  final String imageUrl;
  final bool isLocalImage;
  const AppPhotoView({super.key, required this.imageUrl, required this.isLocalImage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhotoView(
        imageProvider: isLocalImage ? Image.file(File(imageUrl)).image: CachedNetworkImageProvider(imageUrl),
        errorBuilder: (context, e,stack) {
          return const AspectRatio(
            aspectRatio: 9/8,
            child: EmptyView(),
          );
        },
        enableRotation: false,
      ),
    );
  }
}