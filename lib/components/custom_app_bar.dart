import 'package:flutter/material.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class CustomAppBarTheme {
  static const light = ThemeColors.lightElement;
  static const dark = ThemeColors.darkElement;
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? rightIcon;
  final Color? theme;
  final VoidCallback? onRightIconTap;
  final bool hasDrawer;
  final bool isWhiteBackround;

  CustomAppBar({
    this.title,
    this.theme,
    this.rightIcon,
    this.onRightIconTap,
    this.hasDrawer = false,
    this.isWhiteBackround = true,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: widget.isWhiteBackround
          ? ThemeColors.scaffoldColor
          : ThemeColors.primary,
      elevation: 0,
      title: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  _buildLeftIcon,
                  Spacer(),
                  _buildTitle,
                  Spacer(),
                  _buildRightIcon
                ],
              ),
            ],
          )),
    );
  }

  Widget get _buildLeftIcon {
    return InkWell(
      onTap: widget.hasDrawer ? _openDrawer : _closeScreen,
      child: SizedBox(
        height: 30,
        width: 30,
        child: SVGIcon(
          icon: widget.hasDrawer ? AppIcons.menu : AppIcons.back,
          color: widget.theme ?? CustomAppBarTheme.dark,
        ),
      ),
    );
  }

  Widget get _buildTitle {
    return SizedBox(
      height: 25,
      child: Text(
        widget.title ?? "",
        style: TextStyles.semiBold.copyWith(
          color: widget.theme ?? CustomAppBarTheme.dark,
        ),
      ),
    );
  }

  Widget get _buildRightIcon {
    return InkWell(
      onTap: widget.onRightIconTap,
      child: SizedBox(
        height: 27,
        width: 27,
        child: widget.hasDrawer
            ? PNGIcon(icon: AppIcons.notificationPNG)
            : widget.rightIcon,
      ),
    );
  }

  void _closeScreen() {
    Navigator.pop(context);
  }

  void _openDrawer() {
    Scaffold.of(context).openDrawer();
  }
}
