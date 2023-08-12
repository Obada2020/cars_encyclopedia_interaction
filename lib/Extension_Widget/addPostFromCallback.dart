import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  
  Widget addPostFrameCallback(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
    return this;
  }

  Widget inkwell(VoidCallback callback) {
    return InkWell(
      onTap: callback,
      child: this,
    );
  }
}
