import 'package:flutter/material.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: "About"),
      bubblePosition: BackgroundBubblePosition.topRight,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(25),
          child: Text(
            "FINALLY! An App by parents for parents.Grounded saves parents time by allowing them to remotely assign and monitor their children’s math and spelling practice.\n\nWe are all too familiar with the time and responsibility it takes as parents to help our kids practice their math and spelling. \n\nGROUNDED saves parents time by allowing them to remotely assign and monitor their children’s math and spelling practice while keeping them on task.\n\nThe Grounded APP takes the parents place in directing and monitoring their child’s progression through math and spelling exercise.\n\n-	A way for parents to assign and monitor (remotely) children’s math and spelling practice.\n-	Weekly Log report of child’s results\n-	Math and Spelling activities.\n-	Text notification to parents when the child begins and ends assigned task.\n\nThe App takes the child through each level of math or spelling activities, with no progression until the child has answered the present question.",
            style: TextStyles.regular,
          ),
        ),
      ),
    );
  }
}
