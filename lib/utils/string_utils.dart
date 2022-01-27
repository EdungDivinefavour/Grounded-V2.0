import 'dart:math';

String get generateLoginToken {
  final r = Random();
  return List<int>.generate(6, (index) => r.nextInt(10)).fold<String>(
    "",
    (prev, i) => prev += i.toString(),
  );
}
