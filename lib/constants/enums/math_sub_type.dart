final _allMathSubtypes = [
  "Add Doubles",
  "Add Two Numbers Make Ten",
  "Add Three Numbers",
  "Subtract Doubles",
  "Multiply Doubles",
  "Divide Doubles",
  "Find Missing Number",
];

enum MathSubType {
  addDoubles,
  addTwoNumbersMakeTen,
  addThreeNumbers,
  subtractDoubles,
  multiplyDoubles,
  divideDoubles,
  findMissingNumber,
}

extension MathSubTypeExtension on MathSubType {
  String get value => _allMathSubtypes[MathSubType.values.indexOf(this)];
}
