import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/components/svg_icon.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/models/data_points/daily_data_point.dart';
import 'package:grounded/models/managers/grounded_task_manager.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class Reports extends StatefulWidget {
  final Parent parent;
  Reports({required this.parent});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final _firestoreService = FirestoreService.instance;
  final _children = <Child>[];

  final _chartLineColors = [
    MaterialPalette.blue.shadeDefault,
    MaterialPalette.red.shadeDefault,
    MaterialPalette.green.shadeDefault,
    MaterialPalette.yellow.shadeDefault,
    MaterialPalette.pink.shadeDefault,
  ];

  @override
  void initState() {
    super.initState();

    _getChildren();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bubblePosition: BackgroundBubblePosition.bottomLeft,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ScreenTitle(title: "Reports", isWhiteBackround: true),
              SizedBox(
                height: 300,
                child: LineChart(
                  _chartData,
                  domainAxis: NumericAxisSpec(
                    tickProviderSpec:
                        BasicNumericTickProviderSpec(desiredTickCount: 7),
                    tickFormatterSpec: _customTickFormatter,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "These are you child's total points per week. A child can get 10 points for a correct answer. -10 points for an incorrect answer. Click the button below to get a breakdown of the points by tasks.",
                style: TextStyles.regular.copyWith(fontSize: 15),
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildEachTaskReporter('Assigned Tasks', _assignedTasks),
                      VerticalDivider(),
                      _buildEachTaskReporter(
                          'Completed Tasks', _completedTasks),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildEachTaskReporter('Correct Tasks', _correctTasks),
                      VerticalDivider(),
                      _buildEachTaskReporter(
                          'Incorrect Tasks', _incorrectTasks),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEachTaskReporter(String title, int count) {
    String icon = '';
    if (title == "Assigned Tasks") {
      icon = AppIcons.targetPNG;
    } else if (title == "Completed Tasks") {
      icon = AppIcons.tasksPNG;
    } else if (title == "Correct Tasks") {
      icon = AppIcons.correctPNG;
    } else if (title == "Incorrect Tasks") {
      icon = AppIcons.incorrectPNG;
    }

    return Column(
      children: [
        Text(
          title,
          style: TextStyles.medium.copyWith(fontSize: 15),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            PNGIcon(icon: icon, size: 35),
            SizedBox(width: 100),
            Text(
              '$count',
              style: TextStyles.bold.copyWith(fontSize: 26),
            ),
          ],
        )
      ],
    );
  }

  List<Series<DailyDataPoint, int>> get _chartData {
    final List<List<DailyDataPoint>> dataPointList = [];
    for (var child in _children) {
      dataPointList.add(
        GroundedTaskManager.instance.getDailyDataPointsThisWeek(child.tasks),
      );
    }

    return dataPointList.map((x) {
      return Series<DailyDataPoint, int>(
        id: 'Sales',
        colorFn: (_, __) => _chartLineColors[dataPointList.indexOf(x)],
        domainFn: (DailyDataPoint assignment, _) => assignment.dayOfWeek,
        measureFn: (DailyDataPoint assignment, _) => assignment.completedTasks,
        data: x,
      );
    }).toList();
  }

  final _customTickFormatter = BasicNumericTickFormatterSpec((num? value) {
    if (value == 0) {
      return "Mon";
    } else if (value == 2) {
      return "Tue";
    } else if (value == 4) {
      return "Wed";
    } else if (value == 6) {
      return "Thr";
    } else if (value == 8) {
      return "Fri";
    } else if (value == 10) {
      return "Sat";
    } else if (value == 12) {
      return "Sun";
    }

    return "empty";
  });

  int get _assignedTasks {
    int assignedTasks = 0;
    for (var x in _children) {
      assignedTasks += x.tasks.length;
    }

    return assignedTasks;
  }

  int get _completedTasks {
    int completedTasks = 0;
    for (var x in _children) {
      if (x.tasks.isEmpty) continue;

      completedTasks += x.tasks.where((t) => t.hasBeenCompleted).length;
    }

    return completedTasks;
  }

  int get _correctTasks {
    int correctTasks = 0;
    for (var x in _children) {
      correctTasks += x.tasks.where((t) => t.totalPointsGotten == 100).length;
    }

    return correctTasks;
  }

  int get _incorrectTasks {
    int inCorrectTasks = 0;
    for (var x in _children) {
      inCorrectTasks += x.tasks
          .where((t) => t.hasBeenCompleted && t.totalPointsGotten < 100)
          .length;
    }

    return inCorrectTasks;
  }

  void _getChildren() async {
    EasyLoading.show();
    final result = await _firestoreService.getChildrenForParent(widget.parent);

    EasyLoading.dismiss();
    setState(() {
      _children.addAll(result);
    });
  }
}
