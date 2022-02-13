import 'dart:math';

String get generateLoginToken {
  final r = Random();
  return List<int>.generate(6, (index) => r.nextInt(10)).fold<String>(
    "",
    (prev, i) => prev += i.toString(),
  );
}

String shortenToFirstOnly(String name) {
  return name.split(" ")[0];
}

String shortenLastname(String name) {
  return name.split(" ")[0] + " " + name.split(" ")[1].substring(0, 1) + ".";
}
