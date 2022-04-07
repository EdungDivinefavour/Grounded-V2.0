import 'package:intl/intl.dart';

extension IntExtensions on int {
  DateTime get toDateTime {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }

  String get toFormattedDate {
    return DateFormat("MMMM d, yyyy").format(toDateTime);
  }
}
