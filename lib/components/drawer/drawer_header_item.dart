import 'package:grounded/components/user_image.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:flutter/material.dart';

class DrawerHeaderItem extends StatelessWidget {
  final String title;
  final String profilePhoto;
  final bool hasChalkBoardFont;

  const DrawerHeaderItem({
    required this.title,
    required this.profilePhoto,
    this.hasChalkBoardFont = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(top: 17, left: 25),
            child: UserImage(
              imageURL: profilePhoto,
              size: 90,
            )),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(top: 13, left: 25, bottom: 10),
          child: Text(title,
              style: (hasChalkBoardFont
                      ? TextStyles.chalkboard.copyWith(fontSize: 26)
                      : TextStyles.semiBold)
                  .copyWith(color: ThemeColors.lightElement)),
        ),
        const Divider(
            color: ThemeColors.darkElement, height: 20, thickness: 0.2),
        const SizedBox(height: 20)
      ],
    );
  }
}
