import 'package:dart_date/dart_date.dart';
import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/styles/icons/app_icons.dart';
import 'package:grounded/utils/int_utils.dart';
import 'package:grounded/models/managers/question_manager.dart';
import 'package:grounded/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'grounded_task.g.dart';

@JsonSerializable(explicitToJson: true)
class GroundedTask {
  final String id;
  final String name;
  final String parentID;
  final String childID;
  final int creationTimestamp;
  final int expectedCompletionTimestamp;
  final SubjectType subjectType;
  final MathType? mathTypeToCreate;
  final EnglishType? englishTypeToCreate;
  List<Question> questions;

  String get taskIcon => _buildTaskIcon;

  List<Question> get completedQuestions =>
      questions.where((x) => x.hasBeenAnswered).toList();

  int get totalPointsGotten => completedQuestions.length * 10;
  int get completedPercentage =>
      (completedQuestions.length ~/ questions.length) * 100;

  bool get hasBeenCompleted => completedQuestions.length == questions.length;
  int? get completionTimestamp => completedQuestions.last.completedTimestap;

  bool get wasCompletedThisWeek => completionTimestamp == null
      ? false
      : completionTimestamp?.toDateTime.getWeek == DateTime.now().getWeek;

  GroundedTask({
    required this.id,
    required this.name,
    required this.parentID,
    required this.childID,
    required this.creationTimestamp,
    required this.expectedCompletionTimestamp,
    required this.subjectType,
    required this.questions,
    this.mathTypeToCreate,
    this.englishTypeToCreate,
  });

  static GroundedTask newTask({
    required String name,
    required String parentID,
    required String childID,
    required SubjectType subjectType,
    required int expectedCompletionTimestamp,
    MathType? mathTypeToCreate,
    EnglishType? englishTypeToCreate,
  }) {
    final task = GroundedTask(
      id: Uuid().v1(),
      parentID: parentID,
      childID: childID,
      name: name,
      creationTimestamp: DateTime.now().millisecondsSinceEpoch,
      expectedCompletionTimestamp: expectedCompletionTimestamp,
      subjectType: subjectType,
      questions: [],
      mathTypeToCreate: mathTypeToCreate,
      englishTypeToCreate: englishTypeToCreate,
    );

    if (subjectType == SubjectType.maths) {
      QuestionManager.instance.buildMathList(task);
    } else {
      QuestionManager.instance.buildEnglishList(task);
    }
    return task;
  }

  bool wasCompletedOnDay(DateTime dateTime) {
    if (completionTimestamp == null) return false;

    if (completionTimestamp!.toDateTime.year != dateTime.year) {
      return false;
    } else if (completionTimestamp!.toDateTime.month != dateTime.month) {
      return false;
    } else {
      return completionTimestamp!.toDateTime.day == dateTime.day;
    }
  }

  String get _buildTaskIcon {
    if (subjectType == SubjectType.maths) {
      if (mathTypeToCreate == MathType.addition) {
        return AppIcons.additionPNG;
      } else if (mathTypeToCreate == MathType.subtraction) {
        return AppIcons.subtractionPNG;
      } else if (mathTypeToCreate == MathType.multiplication) {
        return AppIcons.multiplicationPNG;
      } else if (mathTypeToCreate == MathType.division) {
        return AppIcons.divisionPNG;
      }
    }

    return AppIcons.englishPNG;
  }

  factory GroundedTask.fromJson(Map<String, dynamic> json) =>
      _$GroundedTaskFromJson(json);

  static List<GroundedTask> fromJsonList(List<dynamic>? list) =>
      list?.map((e) => GroundedTask.fromJson(e)).toList() ?? [];

  Map<String, dynamic> toJson() => _$GroundedTaskToJson(this);
}
