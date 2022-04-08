import 'package:dart_date/dart_date.dart';
import 'package:grounded/constants/enums/english_sub_type.dart';
import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/math_sub_type.dart';
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
  final String parentID;
  final String childID;
  final String childName;
  final String childPhotoUrl;
  final int creationTimestamp;
  final int expectedCompletionTimestamp;
  final SubjectType subjectType;

  final int? numberOfQuestionsToCreate;
  final MathType? mathTypeToCreate;
  final MathSubType? mathSubTypeToCreate;
  final EnglishType? englishTypeToCreate;
  final EnglishSubType? englishSubTypeToCreate;

  List<Question> questions;

  String get taskIcon => _buildTaskIcon;

  List<Question> get completedQuestions =>
      questions.any((x) => x.hasBeenAnswered)
          ? questions.where((x) => x.hasBeenAnswered).toList()
          : [];

  int get totalPointsGotten => completedQuestions.isEmpty
      ? 0
      : completedQuestions.where((x) => x.wasAnsweredCorrectly).length * 10;

  double get completedPercentage =>
      (completedQuestions.length / questions.length) * 100;
  String get completedQuestionsRatio =>
      "${completedQuestions.length}/${questions.length}";

  bool get hasBeenCompleted => completedQuestions.length == questions.length;
  Question? get lastCompletedQuestion =>
      completedQuestions.isEmpty ? null : completedQuestions.last;

  int? get completionTimestamp => lastCompletedQuestion?.completedTimestamp;

  bool get wasCompletedThisWeek => completionTimestamp == null
      ? false
      : completionTimestamp?.toDateTime.getWeek == DateTime.now().getWeek;

  GroundedTask({
    required this.id,
    required this.parentID,
    required this.childID,
    required this.childName,
    required this.childPhotoUrl,
    required this.creationTimestamp,
    required this.expectedCompletionTimestamp,
    required this.subjectType,
    required this.questions,
    this.numberOfQuestionsToCreate,
    this.mathTypeToCreate,
    this.mathSubTypeToCreate,
    this.englishTypeToCreate,
    this.englishSubTypeToCreate,
  });

  static GroundedTask newTask({
    required String parentID,
    required String childID,
    required String childName,
    required String childPhotoUrl,
    required SubjectType subjectType,
    required int expectedCompletionTimestamp,
    int? numberOfQuestionsToCreate,
    MathType? mathTypeToCreate,
    MathSubType? mathSubTypeToCreate,
    EnglishType? englishTypeToCreate,
    EnglishSubType? englishSubTypeToCreate,
  }) {
    final task = GroundedTask(
      id: Uuid().v1(),
      parentID: parentID,
      childID: childID,
      childName: childName,
      childPhotoUrl: childPhotoUrl,
      creationTimestamp: DateTime.now().millisecondsSinceEpoch,
      expectedCompletionTimestamp: expectedCompletionTimestamp,
      subjectType: subjectType,
      numberOfQuestionsToCreate: numberOfQuestionsToCreate,
      questions: [],
      mathTypeToCreate: mathTypeToCreate,
      mathSubTypeToCreate: mathSubTypeToCreate,
      englishTypeToCreate: englishTypeToCreate,
      englishSubTypeToCreate: englishSubTypeToCreate,
    );

    QuestionManager.instance.buildQuestionsForTask(task,
        numberOfQuestions: numberOfQuestionsToCreate ?? 10);
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
