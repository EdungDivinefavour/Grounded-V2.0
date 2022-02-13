extension IntExtensions on int {
  DateTime get toDateTime {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}
