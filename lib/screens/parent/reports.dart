import 'dart:math';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:grounded/components/custom_app_bar/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/models/data_points/daily_data_point.dart';

class Reports extends StatelessWidget {
  final Parent parent;
  Reports({required this.parent});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        bubblePosition: BackgroundBubblePosition.bottomLeft,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ScreenTitle(title: "Reports", isWhiteBackround: true),
              SizedBox(
                height: 350,
                child: LineChart(
                  _chartData,
                  domainAxis: NumericAxisSpec(
                    tickProviderSpec:
                        BasicNumericTickProviderSpec(desiredTickCount: 7),
                    tickFormatterSpec: customTickFormatter,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                  "These are you child's total points per week. A child can get 10 points for a correct answer. -10 points for an incorrect answer. Click the button below to get a breakdown of the points by tasks"),
            ],
          ),
        ));
  }

  List<Series<DailyDataPoint, int>> get _chartData {
    final random = Random();

    final data = [
      DailyDataPoint(dayOfWeek: 1, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 2, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 3, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 4, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 5, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 6, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 7, completedTasks: random.nextInt(10)),
    ];

    final data2 = [
      DailyDataPoint(dayOfWeek: 1, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 2, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 3, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 4, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 5, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 6, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 7, completedTasks: random.nextInt(10)),
    ];

    final data3 = [
      DailyDataPoint(dayOfWeek: 1, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 2, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 3, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 4, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 5, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 6, completedTasks: random.nextInt(10)),
      DailyDataPoint(dayOfWeek: 7, completedTasks: random.nextInt(10)),
    ];

    return [
      Series<DailyDataPoint, int>(
        id: 'Sales',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (DailyDataPoint assignment, _) => assignment.dayOfWeek,
        measureFn: (DailyDataPoint assignment, _) => assignment.completedTasks,
        data: data,
      ),
      Series<DailyDataPoint, int>(
        id: 'Sales',
        colorFn: (_, __) => MaterialPalette.red.shadeDefault,
        domainFn: (DailyDataPoint assignment, _) => assignment.dayOfWeek,
        measureFn: (DailyDataPoint assignment, _) => assignment.completedTasks,
        data: data2,
      ),
      Series<DailyDataPoint, int>(
        id: 'Sales',
        colorFn: (_, __) => MaterialPalette.green.shadeDefault,
        domainFn: (DailyDataPoint assignment, _) => assignment.dayOfWeek,
        measureFn: (DailyDataPoint assignment, _) => assignment.completedTasks,
        data: data3,
      )
    ];
  }

  final customTickFormatter = BasicNumericTickFormatterSpec((num? value) {
    if (value == 0) {
      return "Mon";
    } else if (value == 1) {
      return "Tue";
    } else if (value == 2) {
      return "Wed";
    } else if (value == 3) {
      return "Thr";
    } else if (value == 4) {
      return "Fri";
    } else if (value == 5) {
      return "Sat";
    } else if (value == 6) {
      return "Sun";
    }

    return "empty";
  });
}
