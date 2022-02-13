import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class WeeklyAssignmentData {
  final int dayOfWeek; //This is for the day of the week
  final int count;

  WeeklyAssignmentData({required this.dayOfWeek, required this.count});
}

class Reports extends StatelessWidget {
  final Parent parent;
  const Reports({required this.parent});

  List<charts.Series<dynamic, num>> get seriesList => _createSampleData();
  final bool animate = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 10),
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
            child: Row(
              children: [
                Text(
                  "Reports",
                  style: TextStyles.extraBold.copyWith(fontSize: 23),
                ),
                Spacer(),
                Icon(
                  Icons.expand_outlined,
                  size: 18,
                  color: ThemeColors.darkBackground,
                )
              ],
            ),
          ),
          SizedBox(
              height: 350,
              child: charts.LineChart(seriesList, animate: animate)),
          SizedBox(
            height: 30,
          ),
          Text(
              "These are you child's total points per week. A child can get 10 points for a correct answer. -10 points for an incorrect answer. Click the button below to get a breakdown of the points by tasks"),
        ],
      ),
    ));
  }

  static List<charts.Series<WeeklyAssignmentData, int>> _createSampleData() {
    final data = [
      WeeklyAssignmentData(dayOfWeek: 1, count: 5),
      WeeklyAssignmentData(dayOfWeek: 2, count: 2),
      WeeklyAssignmentData(dayOfWeek: 3, count: 9),
      WeeklyAssignmentData(dayOfWeek: 4, count: 3),
      WeeklyAssignmentData(dayOfWeek: 5, count: 5),
      WeeklyAssignmentData(dayOfWeek: 6, count: 2),
      WeeklyAssignmentData(dayOfWeek: 7, count: 7),
    ];

    return [
      charts.Series<WeeklyAssignmentData, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WeeklyAssignmentData assignment, _) => assignment.dayOfWeek,
        measureFn: (WeeklyAssignmentData assignment, _) => assignment.count,
        data: data,
      )
    ];
  }
}
