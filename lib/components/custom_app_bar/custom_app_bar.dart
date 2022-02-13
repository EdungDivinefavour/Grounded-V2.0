import 'package:flutter/material.dart';
import 'package:grounded/components/empty_widget.dart';
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
  final String? lowerTitle;
  final Widget? rightIcon;
  final Color? theme;
  final bool hasDrawer;

  CustomAppBar({
    this.title,
    this.lowerTitle,
    this.rightIcon,
    this.theme,
    this.hasDrawer = false,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(130);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: _buildAppBarMargin,
        padding: EdgeInsets.symmetric(vertical: 10),
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
            _buildLowerTitle
          ],
        ));
  }

  Widget get _buildLeftIcon {
    return InkWell(
      onTap: widget.hasDrawer ? _openDrawer : _closeScreen,
      child: SizedBox(
        height: 25,
        width: 25,
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

  Widget get _buildLowerTitle {
    if (widget.lowerTitle == null) return emptyWidget;

    return Container(
      margin: EdgeInsets.only(top: 40, left: 5),
      alignment: Alignment.centerLeft,
      child: Text(
        widget.lowerTitle!,
        style: TextStyles.extraBold.copyWith(
          fontSize: 25,
          color: widget.theme ?? CustomAppBarTheme.dark,
        ),
      ),
    );
  }

  Widget get _buildRightIcon {
    return SizedBox(
      height: 25,
      width: 25,
      child: widget.hasDrawer
          ? SVGIcon(icon: AppIcons.notification)
          : widget.rightIcon,
    );
  }

  EdgeInsetsGeometry? get _buildAppBarMargin {
    if (widget.hasDrawer) {
      return EdgeInsets.only(top: 50, left: 15, right: 15);
    } else if (widget.lowerTitle != null) {
      return EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 15);
    }

    return null;
  }

  void _closeScreen() {
    Navigator.pop(context);
  }

  void _openDrawer() {
    Scaffold.of(context).openDrawer();
  }
}
