import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class HomeChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Container(
            margin: EdgeInsets.all(20),
            child: Column(children: [
              Row(
                children: [
                  Icon(Icons.list_outlined),
                  Spacer(),
                  Icon(Icons.notifications)
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hey Sarah!",
                  style: TextStyles.extraBold.copyWith(fontSize: 24),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ready to make your parents proud today?",
                  style: TextStyles.regular,
                ),
              ),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pending Tasks",
                  style: TextStyles.extraBold.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(height: 20)
            ])));
  }
}
