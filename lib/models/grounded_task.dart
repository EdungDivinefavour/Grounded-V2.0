import 'package:grounded/constants/enums/question_type.dart';
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
  final QuestionType questionTypeToCreate;
  final List<Question> questions;

  GroundedTask({
    required this.id,
    required this.name,
    required this.parentID,
    required this.childID,
    required this.creationTimestamp,
    required this.expectedCompletionTimestamp,
    required this.questionTypeToCreate,
    required this.questions,
  });

  static GroundedTask newTask({
    required String name,
    required String parentID,
    required String childID,
    required QuestionType questionTypeToCreate,
    required int expectedCompletionTimestamp,
  }) {
    return GroundedTask(
      id: Uuid().v1(),
      parentID: parentID,
      childID: childID,
      name: name,
      creationTimestamp: DateTime.now().millisecondsSinceEpoch,
      expectedCompletionTimestamp: expectedCompletionTimestamp,
      questionTypeToCreate: questionTypeToCreate,
      questions: [],
    );
  }

  factory GroundedTask.fromJson(Map<String, dynamic> json) =>
      _$GroundedTaskFromJson(json);
  Map<String, dynamic> toJson() => _$GroundedTaskToJson(this);
}
