import 'package:flutter/material.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class AssignedTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: "Assigned Tasks"),
      bubblePosition: BackgroundBubblePosition.topRight,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Text("Yet to be worked on", style: TextStyles.regular),
        ),
      ),
    );
  }
}
