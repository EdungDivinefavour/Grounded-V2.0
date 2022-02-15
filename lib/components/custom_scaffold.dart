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
    this.bubblePosition,
    this.backgroundColor = ThemeColors.lightElement,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      // body: Stack(
      //   children: [SafeArea(child: widget.body), _buildBubble],
      // ),
      body: widget.body,
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: widget.bottomNavigationBar,
      backgroundColor: widget.backgroundColor,
    );
  }

  Widget get _buildBubble {
    if (widget.bubblePosition == BackgroundBubblePosition.bottomLeft) {
      return Positioned(
        bottom: 0,
        left: 0,
        child: SVGIcon(icon: AppIcons.bottomLeftBubble),
      );
    } else if (widget.bubblePosition == BackgroundBubblePosition.centerLeft) {
      return Positioned(
        top: getDeviceHeight(context) / 2,
        left: 0,
        child: SVGIcon(icon: AppIcons.centerLeftBubble),
      );
    } else if (widget.bubblePosition == BackgroundBubblePosition.centerRight) {
      return Positioned(
          top: getDeviceHeight(context) / 2,
          right: 0,
          child: SVGIcon(icon: AppIcons.centerRightBubble));
    } else if (widget.bubblePosition == BackgroundBubblePosition.none) {
      return emptyWidget;
    }

    return Positioned(
        top: 0, right: 0, child: SVGIcon(icon: AppIcons.topRightBubble));
  }
}
