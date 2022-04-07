import 'package:flutter/material.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/constants/strings/paths.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/utils/null_utils.dart';

class UserImage extends StatelessWidget {
  final String? imageURL;
  final double? size;

  const UserImage({this.imageURL, this.size = 160});

  @override
  Widget build(BuildContext context) {
    final failedIcon =
        SVGIcon(icon: AppIcons.fetchedImageFailedSVG, size: size);

    return toWidget<String>(
      imageURL,
      builder: (url) => ClipRRect(
        borderRadius: BorderRadius.circular(150.0),
        child: FadeInImage.assetNetwork(
            placeholder: iconPath + AppIcons.fetchedImageFailedPNG,
            image: url,
            height: size,
            width: size,
            fit: BoxFit.cover,
            imageErrorBuilder: (_, __, ___) => failedIcon),
      ),
      orElse: () => failedIcon,
    );
  }
}
