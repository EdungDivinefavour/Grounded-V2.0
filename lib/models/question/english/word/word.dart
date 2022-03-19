import 'package:grounded/constants/enums/english_sub_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

@JsonSerializable(explicitToJson: true)
class Word {
  final EnglishSubType type;
  String text;

  Word({
    required this.text,
    required this.type,
  }) {
    text = text.toUpperCase();
  }

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  Map<String, dynamic> toJson() => _$WordToJson(this);
}
