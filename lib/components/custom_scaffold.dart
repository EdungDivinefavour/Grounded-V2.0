import 'package:flutter/material.dart';
import 'package:grounded/styles/colors/theme_colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  const CustomScaffold({
    required this.body,
    this.drawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: body),
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor ?? ThemeColors.lightElement,
    );
  }
}
