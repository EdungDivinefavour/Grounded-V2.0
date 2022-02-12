import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/models/weekly_assignment_data.dart';

class Reports extends StatelessWidget {
  final Parent parent;
  const Reports({required this.parent});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Column(
      children: [
        SizedBox(height: 40),
        Text("Reports"),
        SizedBox(
          height: 350,
          child: charts.LineChart(_chartData, animate: true),
        ),
        Text("These are you child's total points per week etc etc etc"),
      ],
    ));
  }

  List<charts.Series<WeeklyAssignmentData, int>> get _chartData {
    final random = Random();

    final data = [
      WeeklyAssignmentData(dayOfWeek: 1, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 2, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 3, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 4, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 5, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 6, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 7, count: random.nextInt(10)),
    ];

    final data2 = [
      WeeklyAssignmentData(dayOfWeek: 1, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 2, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 3, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 4, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 5, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 6, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 7, count: random.nextInt(10)),
    ];

    final data3 = [
      WeeklyAssignmentData(dayOfWeek: 1, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 2, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 3, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 4, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 5, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 6, count: random.nextInt(10)),
      WeeklyAssignmentData(dayOfWeek: 7, count: random.nextInt(10)),
    ];

    return [
      charts.Series<WeeklyAssignmentData, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (WeeklyAssignmentData assignment, _) => assignment.dayOfWeek,
        measureFn: (WeeklyAssignmentData assignment, _) => assignment.count,
        data: data,
      ),
      charts.Series<WeeklyAssignmentData, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (WeeklyAssignmentData assignment, _) => assignment.dayOfWeek,
        measureFn: (WeeklyAssignmentData assignment, _) => assignment.count,
        data: data2,
      ),
      charts.Series<WeeklyAssignmentData, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (WeeklyAssignmentData assignment, _) => assignment.dayOfWeek,
        measureFn: (WeeklyAssignmentData assignment, _) => assignment.count,
        data: data3,
      )
    ];
  }
}
