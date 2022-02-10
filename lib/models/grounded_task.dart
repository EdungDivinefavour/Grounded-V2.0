import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/question_category.dart';
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
  final QuestionCategory questionCategoryToCreate;
  final MathType? mathTypeToCreate;
  final EnglishType? englishTypeToCreate;
  List<Question> questions;

  int get completedQuestions =>
      questions.where((x) => x.hasBeenAnswered).toList().length;

  int get completedPercentage => completedQuestions ~/ questions.length;

  GroundedTask({
    required this.id,
    required this.name,
    required this.parentID,
    required this.childID,
    required this.creationTimestamp,
    required this.expectedCompletionTimestamp,
    required this.questionCategoryToCreate,
    required this.questions,
    this.mathTypeToCreate,
    this.englishTypeToCreate,
  });

  static GroundedTask newTask({
    required String name,
    required String parentID,
    required String childID,
    required QuestionCategory questionCategoryToCreate,
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
      questionCategoryToCreate: questionCategoryToCreate,
      questions: [],
      mathTypeToCreate: mathTypeToCreate,
      englishTypeToCreate: englishTypeToCreate,
    );

    if (questionCategoryToCreate == QuestionCategory.maths) {
      QuestionManager.instance.buildMathList(task);
    } else {
      QuestionManager.instance.buildEnglishList(task);
    }
    return task;
  }

  factory GroundedTask.fromJson(Map<String, dynamic> json) =>
      _$GroundedTaskFromJson(json);

  static List<GroundedTask> fromJsonList(List<dynamic>? list) =>
      list?.map((e) => GroundedTask.fromJson(e)).toList() ?? [];

  Map<String, dynamic> toJson() => _$GroundedTaskToJson(this);
}
