import 'package:grounded/models/grounded_task/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grounded_task.g.dart';

@JsonSerializable(explicitToJson: true)
class GroundedTask {
  final int creationTime;
  final List<Question> questions;

  GroundedTask({
    required this.creationTime,
    required this.questions,
  });
}
