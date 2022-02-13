import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Add New Task",
                  style: TextStyles.medium,
                ),
              ),
              // InputField(
              //   controller: controller, hintText: "Enter the name of the task", title: "Task Name")
            ],
          ),
        ),
      ),
    ));
  }
}
