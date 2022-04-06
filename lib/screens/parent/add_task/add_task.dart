import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grounded/components/custom_action_button.dart';
import 'package:grounded/components/custom_app_bar.dart';
import 'package:grounded/components/custom_scaffold.dart';
import 'package:grounded/components/dialog_list_item.dart';
import 'package:grounded/components/input_field.dart';
import 'package:grounded/components/png_icon.dart';
import 'package:grounded/components/user_image.dart';
import 'package:grounded/constants/enums/english_sub_type.dart';
import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/math_sub_type.dart';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/screens/parent/add_task/multiplication_choice.dart';
import 'package:grounded/screens/parent/task_sent.dart';
import 'package:grounded/services/audio/audio_player.dart';
import 'package:grounded/services/firebase/firestore_service.dart';
import 'package:grounded/styles/colors/theme_colors.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/styles/texts/text_styles.dart';

class AddTask extends StatefulWidget {
  final Parent parent;
  final Child child;

  const AddTask({required this.parent, required this.child});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> with TickerProviderStateMixin {
  final _firestoreService = FirestoreService.instance;

  late TabController _tabController;
  final _expectedCompletionDateController = TextEditingController();
  final _expectedCompletionTimeController = TextEditingController();

  DateTime? _compiledDateAndTime;

  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;

  SubjectType _selectedSubjectType = SubjectType.maths;

  MathType? _selectedMathType;
  EnglishType? _selectedEnglishType;

  EnglishSubType? _selectedEnglishSubType;
  MathSubType? _selectedMathSubType;

  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(title: "Add  Task"),
        bubblePosition: BackgroundBubblePosition.topRight,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 910,
            child: Column(
              children: [
                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        UserImage(
                            imageURL: widget.child.profilePhoto, size: 80),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(widget.child.name,
                                    style: TextStyles.semiBold),
                                SizedBox(width: 5),
                                Text("(${widget.child.age} years old)",
                                    style: TextStyles.regular
                                        .copyWith(fontSize: 15))
                              ],
                            ),
                            SizedBox(height: 10),
                            Text("Grade ${widget.child.grade}",
                                style:
                                    TextStyles.regular.copyWith(fontSize: 15)),
                            SizedBox(height: 10),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                SizedBox(height: 20),
                InputField(
                  title: "Expected completion date",
                  hintText: "Click here to pick a date",
                  leftIcon: AppIcons.calendarPNG,
                  shouldUsePNG: true,
                  hasBorder: true,
                  controller: _expectedCompletionDateController,
                  onTap: _openDatePicker,
                ),
                SizedBox(height: 30),
                InputField(
                  title: "Expected completion time",
                  hintText: "Click here to pick a time",
                  shouldUsePNG: true,
                  hasBorder: true,
                  leftIcon: AppIcons.clockPNG,
                  controller: _expectedCompletionTimeController,
                  onTap: _openTimePicker,
                ),
                SizedBox(height: 30),
                _buildSubjectTabs,
                SizedBox(height: 40),
                CustomActionButton(
                    onPressed: _addTask, title: "Send Task", isRedButton: true),
                SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }

  Widget get _buildSubjectTabs {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ThemeColors.primaryDark),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTabHeader(title: "Maths", index: 0),
              _buildTabHeader(title: "English", index: 1),
            ],
          ),
        ),
        SizedBox(
          height: 330,
          child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [_buildMathsTabContent(), _buildEnglishTabContent()]),
        )
      ],
    );
  }

  Widget _buildTabHeader({required String title, required int index}) {
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
        setState(() {
          _currentTabIndex = index;
          _selectedSubjectType = SubjectType.values[_currentTabIndex];
        });
      },
      child: Container(
          alignment: Alignment.center,
          height: 43,
          width: (MediaQuery.of(context).size.width - 42) / 2,
          decoration: BoxDecoration(
              color: _currentTabIndex == index
                  ? ThemeColors.primaryDark
                  : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Text(title,
              style: TextStyles.semiBold.copyWith(
                  fontSize: 16,
                  color: _currentTabIndex == index
                      ? Colors.white
                      : ThemeColors.primaryDark))),
    );
  }

  Widget _buildEnglishTabContent() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildEnglishSubTypeContainer(EnglishSubType.animal),
              _buildEnglishSubTypeContainer(EnglishSubType.person),
              _buildEnglishSubTypeContainer(EnglishSubType.thing),
            ],
          ),
          SizedBox(height: 20),
          Row(children: [_buildEnglishSubTypeContainer(EnglishSubType.place)]),
        ],
      ),
    );
  }

  Widget _buildEnglishSubTypeContainer(EnglishSubType englishSubType) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedEnglishType = EnglishType.general;
          _selectedEnglishSubType = englishSubType;
        });
      },
      child: Container(
        height: 100,
        width: 90,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.5,
                color: _selectedEnglishSubType == englishSubType
                    ? ThemeColors.error.withOpacity(0.8)
                    : ThemeColors.darkBackground.withOpacity(0.2)),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PNGIcon(
                icon: '${englishSubType.value.toLowerCase()}.png', size: 50),
            SizedBox(height: 10),
            Text(englishSubType.value,
                style: TextStyles.semiBold.copyWith(fontSize: 13))
          ],
        ),
      ),
    );
  }

  MathType? _tappedMathType;
  Widget _buildMathsTabContent() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: ListView.builder(
          itemCount: 4,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            final itrMathType = MathType.values[i];

            return InkWell(
              onTap: () {
                _tappedMathType = _selectedMathType = itrMathType;
                _showMathSubTypeAlert();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: _selectedMathType == MathType.values[i]
                            ? itrMathType.color
                            : ThemeColors.darkBackground.withOpacity(0.2)),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                height: 60,
                child: Row(
                  children: [
                    Icon(
                      itrMathType.icon,
                      color: itrMathType.color,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      MathType.values[i].value,
                      style: TextStyles.semiBold
                          .copyWith(fontSize: 16, color: itrMathType.color),
                    ),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: itrMathType.color,
                      size: 30,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildMathSubTypeList(sts) {
    if (_selectedMathType == MathType.multiplication) {
      final mathSubTypeList =
          MathSubType.values.where((x) => x.value.toLowerCase().contains("x"));

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 300,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.5),
          children: mathSubTypeList
              .map((x) => MultiplicationChoice(
                  title: x.value,
                  stateSetter: sts,
                  isSelected: x == _selectedMathSubType,
                  onTap: () {
                    setState(() {
                      _selectedMathSubType = x;
                    });
                  }))
              .toList(),
        ),
      );
    } else {
      final mathSubTypeList = MathSubType.values.where((x) =>
          x.value.toLowerCase().contains("find") ||
          x.value.toLowerCase().contains(
              _selectedMathType!.value.toLowerCase().substring(0, 3)));

      return Column(
        children: mathSubTypeList
            .map((mathSubType) => DialogListItem(
                title:
                    '${mathSubType.value} | ${mathSubType.example(mathType: _tappedMathType)}',
                onTap: () {
                  setState(() {
                    _selectedMathSubType = mathSubType;
                  });
                },
                stateSetter: sts,
                isSelected: _selectedMathSubType == mathSubType,
                textColor: ThemeColors.primary,
                iconColor: ThemeColors.primary))
            .toList(),
      );
    }
  }

  void _showMathSubTypeAlert() {
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(builder: (context, sts) {
          return Dialog(
            backgroundColor: ThemeColors.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: SizedBox(
                height: _selectedMathType == MathType.addition
                    ? 420
                    : _selectedMathType == MathType.multiplication
                        ? 400
                        : 260,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 17, left: 12, right: 12, bottom: 5),
                      child: Row(
                        children: [
                          Icon(_tappedMathType!.icon,
                              color: ThemeColors.lightElement, size: 35),
                          SizedBox(width: 10),
                          Text(_tappedMathType!.value,
                              style: TextStyles.semiBold.copyWith(
                                  fontSize: 17,
                                  color: ThemeColors.lightElement)),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_up,
                              color: ThemeColors.lightElement, size: 30),
                        ],
                      ),
                    ),
                    Divider(color: ThemeColors.lightElement, thickness: 1),
                    SizedBox(height: 10),
                    _buildMathSubTypeList(sts),
                    SizedBox(height: 10)
                  ],
                )),
          );
        });
      },
    );
  }

  void _openDatePicker() async {
    _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940, 8),
        lastDate: DateTime(2101));
    if (_pickedDate == null) return;

    setState(() {
      _expectedCompletionDateController.text =
          "${_pickedDate!.day} - ${_pickedDate!.month} - ${_pickedDate!.year}";
    });
  }

  void _openTimePicker() async {
    if (_pickedDate == null) {
      EasyLoading.showError("Please pick a date first");
      return;
    }

    _pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 00, minute: 00),
    );

    if (_pickedTime == null) return;
    _compiledDateAndTime = DateTime(
      _pickedDate!.year,
      _pickedDate!.month,
      _pickedDate!.day,
      _pickedDate!.hour,
      _pickedDate!.minute,
    );

    setState(() {
      _expectedCompletionTimeController.text =
          "${_pickedTime!.hour} : ${_pickedTime!.minute}";
    });
  }

  void _addTask() async {
    if (!_allFieldsPassedValidation) {
      EasyLoading.showError("Please fill out all the empty fields to proceed");
      return;
    }

    EasyLoading.show();
    final task = GroundedTask.newTask(
      parentID: widget.parent.id,
      childID: widget.child.id,
      childName: widget.child.name,
      childPhotoUrl: widget.child.profilePhoto,
      subjectType: _selectedSubjectType,
      mathTypeToCreate: _selectedMathType,
      mathSubTypeToCreate: _selectedMathSubType,
      englishTypeToCreate: _selectedEnglishType,
      englishSubTypeToCreate: _selectedEnglishSubType,
      expectedCompletionTimestamp: _compiledDateAndTime!.millisecondsSinceEpoch,
    );

    await _firestoreService.storeTask(task: task, child: widget.child);
    EasyLoading.dismiss();
    await AudioPlayer.instance.play(AudioTones.swoosh);

    _openTaskSentScreen(task);
  }

  void _openTaskSentScreen(GroundedTask task) async {
    final wantsToSendAnotherTask = await Navigator.push<bool>(
        context,
        MaterialPageRoute<bool>(
            builder: (BuildContext context) =>
                TaskSent(child: widget.child, task: task)));

    if (!wantsToSendAnotherTask!) return;
    setState(() {
      _selectedMathType = null;
      _selectedMathSubType = null;
      _selectedEnglishType = null;
      _selectedEnglishSubType = null;
    });
  }

  bool get _allFieldsPassedValidation {
    if (_selectedSubjectType == SubjectType.maths &&
        (_selectedMathType == null || _selectedMathSubType == null)) {
      return false;
    } else if (_selectedSubjectType == SubjectType.english &&
        _selectedEnglishSubType == null) {
      return false;
    } else if (_expectedCompletionDateController.text == "") {
      return false;
    } else if (_expectedCompletionTimeController.text == "") {
      return false;
    }

    return true;
  }
}
