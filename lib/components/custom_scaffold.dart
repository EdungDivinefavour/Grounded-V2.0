import 'package:flutter/material.dart';
import 'package:grounded/components/empty_widget.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/utils/device_utils.dart';

enum BackgroundBubblePosition {
  topLeft,
  topRight,
  centerLeft,
  centerRight,
  bottomRight,
  bottomLeft,
  none,
}

class CustomScaffold extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final BackgroundBubblePosition? bubblePosition;
  final Color backgroundColor;

  const CustomScaffold({
    required this.body,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.bubblePosition = BackgroundBubblePosition.none,
    this.backgroundColor = ThemeColors.lightElement,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: widget.appBar,
          body: widget.body,
          drawer: widget.drawer,
          floatingActionButton: widget.floatingActionButton,
          bottomNavigationBar: widget.bottomNavigationBar,
          backgroundColor: widget.backgroundColor,
        ),
        _buildBubble
      ],
    );
  }

  Widget get _buildBubble {
    if (widget.bubblePosition == BackgroundBubblePosition.bottomLeft) {
      return Positioned(
        bottom: -30,
        left: 0,
        child: SVGIcon(
            icon: AppIcons.bottomLeftBubble, color: ThemeColors.primary),
      );
    } else if (widget.bubblePosition == BackgroundBubblePosition.centerLeft) {
      return Positioned(
        top: getDeviceHeight(context) / 3.5,
        left: 0,
        child: SVGIcon(
            icon: AppIcons.centerLeftBubble, color: ThemeColors.primary),
      );
    } else if (widget.bubblePosition == BackgroundBubblePosition.centerRight) {
      return Positioned(
          top: getDeviceHeight(context) / 3.5,
          right: 0,
          child: SVGIcon(
              icon: AppIcons.centerRightBubble, color: ThemeColors.primary));
    } else if (widget.bubblePosition == BackgroundBubblePosition.topRight) {
      return emptyWidget;
      // return Positioned(
      //     top: 0,
      //     right: 0,
      //     child: SVGIcon(
      //         icon: AppIcons.topRightBubble, color: ThemeColors.primary));
    }

    return emptyWidget;
  }
}
