import 'package:flutter/material.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/constants/strings/paths.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/utils/null_utils.dart';

class UserImage extends StatelessWidget {
  final String? imageURL;
  final double? height;
  final double? width;

  const UserImage({this.imageURL, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    final failedIcon = SVGIcon(
        icon: AppIcons.fetchedImageFailedSVG, height: height, width: width);

    return toWidget<String>(
      imageURL,
      builder: (url) => FadeInImage.assetNetwork(
          placeholder: iconPath + AppIcons.fetchedImageFailedPNG,
          image: url,
          height: height,
          width: width,
          imageErrorBuilder: (_, __, ___) => failedIcon),
      orElse: () => failedIcon,
    );
  }
}
