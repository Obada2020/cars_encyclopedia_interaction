import 'package:flutter/cupertino.dart';

extension WidgetExtension on Widget {
  Widget addPostFrameCallback(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
    return this;
  }
}
