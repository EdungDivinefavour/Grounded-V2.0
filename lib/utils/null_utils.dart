import 'package:flutter/material.dart';
import 'package:grounded/components/empty_widget.dart';

/// It will convert null to specified widget using builder
/// or it will return empty widget or you can provide your own else width builder
Widget toWidget<T extends Object>(T? value,
    {required Widget Function(T value) builder, ValueGetter<Widget>? orElse}) {
  if (value == null) return orElse?.call() ?? emptyWidget;

  return builder.call(value);
}
