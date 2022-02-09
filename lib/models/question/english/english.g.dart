// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'english.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

English _$EnglishFromJson(Map<String, dynamic> json) => English(
      word: Word.fromJson(json['word'] as Map<String, dynamic>),
      suggestedAnswers: (json['suggestedAnswers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    )
      ..displayedQuestion = json['displayedQuestion'] as String?
      ..pickedAnswer = json['pickedAnswer'] as String?
      ..correctAnswer = json['correctAnswer'] as String?;

Map<String, dynamic> _$EnglishToJson(English instance) => <String, dynamic>{
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'word': instance.word.toJson(),
      'suggestedAnswers': instance.suggestedAnswers,
    };
