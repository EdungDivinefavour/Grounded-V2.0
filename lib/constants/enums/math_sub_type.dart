import 'package:grounded/constants/enums/math_type.dart';

final _allMathSubtypes = [
  "Add Doubles",
  "Add Two Numbers Make Ten",
  "Add Three Numbers",
  "Subtract Doubles",
  "Divide Doubles",
  "Find Missing Number",
  "1 x",
  "2 x",
  "3 x",
  "4 x",
  "5 x",
  "6 x",
  "7 x",
  "8 x",
  "9 x",
  "10 x",
  "11 x",
  "12 x",
];

enum MathSubType {
  addDoubles,
  addTwoNumbersMakeTen,
  addThreeNumbers,
  subtractDoubles,
  divideDoubles,
  findMissingNumber,
  oneX,
  twoX,
  threeX,
  fourX,
  fiveX,
  sixX,
  sevenX,
  eightX,
  nineX,
  tenX,
}

extension MathSubTypeExtension on MathSubType {
  String get value => _allMathSubtypes[MathSubType.values.indexOf(this)];

  String example({MathType? mathType}) {
    if (this == MathSubType.addDoubles) {
      return "12 + 13";
    } else if (this == MathSubType.addThreeNumbers) {
      return "4 + 7 + 9";
    } else if (this == MathSubType.addTwoNumbersMakeTen) {
      return "3 + ? = 10";
    } else if (this == MathSubType.divideDoubles) {
      return "60 ÷ 20";
    } else if (this == MathSubType.findMissingNumber) {
      return "? ${_buildMathTypeSymbol(mathType)} 7 = 9";
    } else if (this == MathSubType.subtractDoubles) {
      return "35 - 16";
    }
    return ("No examples found");
  }

  String _buildMathTypeSymbol(MathType? mathType) {
    if (mathType == MathType.addition) {
      return "+";
    } else if (mathType == MathType.subtraction) {
      return "-";
    } else if (mathType == MathType.division) {
      return "÷";
    } else if (mathType == MathType.multiplication) {
      return "x";
    }
    return ("No sign found");
  }
}
