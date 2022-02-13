import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/styles/texts/text_styles.dart';
import 'package:flutter/material.dart';

class DrawerHeaderItem extends StatelessWidget {
  final String title;
  final String profilePhoto;

  const DrawerHeaderItem({
    required this.title,
    required this.profilePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(top: 17, left: 25),
            child: SizedBox(
                width: 60, height: 60, child: SVGIcon(icon: profilePhoto))),
        Container(
          margin: const EdgeInsets.only(top: 13, left: 25, bottom: 10),
          child: Text(title, style: TextStyles.bold),
        ),
        const Divider(color: Colors.black, height: 20, thickness: 0.2),
        const SizedBox(height: 20)
      ],
    );
  }
}
