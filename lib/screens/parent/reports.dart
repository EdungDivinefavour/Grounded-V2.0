import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/dialog_list_item.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/screen_title.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/models/data_points/daily_data_point.dart';
import 'package:grounded/models/managers/grounded_task_manager.dart';
import 'package:grounded/screens/parent/assigned_tasks.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class Reports extends StatefulWidget {
  final Parent parent;
  Reports({required this.parent});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final _selectedChildController = TextEditingController();
  final _firestoreService = FirestoreService.instance;

  final _children = <Child>[];
  final _childrenDuplicate = <Child>[];

  Child? _selectedChild;

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
              Stack(
                children: [
                  ScreenTitle(title: "Reports", isWhiteBackround: true),
                  Positioned(
                    top: 27.5,
                    right: 0,
                    child: TextButton(
                        onPressed: _openAssignedTasksScreen,
                        child: Text("View details of tasks",
                            style: TextStyles.semiBold.copyWith(fontSize: 15))),
                  ),
                ],
              ),
              InputField(
                title: "",
                controller: _selectedChildController,
                hintText: "Click here to view for a particular child",
                hasBorder: true,
                shouldUsePNG: true,
                onTap: _showChildPicker,
                leftIcon: AppIcons.childPNG,
                shouldRemoveTitle: true,
                onCancelIconTap: _clearSelectedChild,
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 250,
                child: LineChart(
                  _chartData,
                  domainAxis: NumericAxisSpec(
                    tickProviderSpec:
                        BasicNumericTickProviderSpec(desiredTickCount: 7),
                    tickFormatterSpec: _customTickFormatter,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                "These are you child's total points per week. A child can get 10 points for a correct answer. -10 points for an incorrect answer",
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

  void _showChildPicker() {
    _children.clear();
    _children.addAll(_childrenDuplicate);

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, sts) {
          return Dialog(
            backgroundColor: ThemeColors.primaryDark,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: SizedBox(
                height: (115 * _childrenDuplicate.length).toDouble(),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 17, left: 12, right: 12, bottom: 5),
                      child: Row(
                        children: [
                          Icon(Icons.child_care,
                              color: ThemeColors.lightElement, size: 35),
                          SizedBox(width: 10),
                          Text("Select Child",
                              style: TextStyles.semiBold.copyWith(
                                  fontSize: 17,
                                  color: ThemeColors.lightElement)),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_down,
                              color: ThemeColors.lightElement, size: 30),
                        ],
                      ),
                    ),
                    Divider(color: ThemeColors.lightElement, thickness: 1),
                    SizedBox(height: 10),
                    Column(
                      children: _childrenDuplicate
                          .map((x) => DialogListItem(
                              title: x.name,
                              stateSetter: sts,
                              isSelected: _selectedChild == x,
                              onTap: () {
                                _onChildSelected(x);
                              }))
                          .toList(),
                    )
                  ],
                )),
          );
        });
      },
    );
  }

  void _onChildSelected(Child child) async {
    _selectedChild = child;

    _children.removeWhere((x) => x != child);
    _selectedChildController.text = child.name;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 100));
    Navigator.pop(context);
  }

  void _getChildren() async {
    EasyLoading.show();
    final result = await _firestoreService.getChildrenForParent(widget.parent);

    EasyLoading.dismiss();
    setState(() {
      _children.addAll(result);
      _childrenDuplicate.addAll(_children);
    });
  }

  void _clearSelectedChild() {
    _selectedChild = null;

    _selectedChildController.clear();
    _children.clear();
    _children.addAll(_childrenDuplicate);

    setState(() {});
  }

  void _openAssignedTasksScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => AssignedTask(child: _selectedChild)));
  }
}
