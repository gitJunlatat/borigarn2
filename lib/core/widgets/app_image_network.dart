import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';



class AppImageNetwork extends StatelessWidget {
  final String? imageUrl;
  final Widget? errorWidget;
  final PlaceholderWidgetBuilder? placeholder;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Color backgroundColor;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final BaseCacheManager? cacheManager;

  const AppImageNetwork({
    super.key,
    required this.imageUrl,
    this.errorWidget,
    this.placeholder,
    this.width,
    this.height,
    this.fit,
    this.borderRadius = 0,
    this.borderWidth = 0,
    this.borderColor = const Color(0xFFDCDBD9),
    this.backgroundColor = Colors.white,
    this.fadeInDuration = const Duration(milliseconds: 0),
    this.fadeOutDuration = const Duration(milliseconds: 0),
    this.cacheManager,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderWidth != 0
            ? Border.all(
          width: borderWidth,
          color: borderColor,
        )
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: (imageUrl ?? "").isNotNullEmpty
            ? CachedNetworkImage(
          cacheManager: cacheManager,
          width: width,
          height: height,
          fit: fit,
          imageUrl: imageUrl!,
          fadeInDuration: fadeInDuration,
          fadeOutDuration: fadeOutDuration,
          placeholder: placeholder,
          errorWidget: (context, url, error) => errorWidget ?? const Text('')

      ) : const Text('')
    ),
    );
  }
}



extension NullableStringExtensions on String? {
  bool get isNullEmpty => this == null || this == "";
}

extension NotNullableStringExtensions on String? {
  bool get isNotNullEmpty => this != null && this != "";
}