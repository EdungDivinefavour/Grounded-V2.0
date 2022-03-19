import 'package:grounded/constants/enums/math_sub_type.dart';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'math.g.dart';

@JsonSerializable(explicitToJson: true)
class Math extends Question {
  @override
  final SubjectType subjectType;
  @override
  String? displayedQuestion;
  @override
  String? pickedAnswer;
  @override
  String? correctAnswer;
  @override
  int? completedTimestamp;
  @override
  final MathType mathType;
  @override
  final MathSubType mathSubType;

  Math({
    required this.mathType,
    required this.mathSubType,
    this.subjectType = SubjectType.maths,
    this.displayedQuestion,
    this.pickedAnswer,
    this.completedTimestamp,
  }) : super(
          subjectType: subjectType,
          mathType: mathType,
          mathSubType: mathSubType,
          displayedQuestion: displayedQuestion,
          pickedAnswer: pickedAnswer,
          correctAnswer: pickedAnswer,
          completedTimestamp: completedTimestamp,
        );

  factory Math.fromJson(Map<String, dynamic> json) => _$MathFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MathToJson(this);
}
