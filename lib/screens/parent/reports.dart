import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';

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
        body: Column(
      children: [
        SizedBox(height: 40),
        Text("Reports"),
        SizedBox(
            height: 350, child: charts.LineChart(seriesList, animate: animate)),
        Text("These are you child's total points per week etc etc etc"),
      ],
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
