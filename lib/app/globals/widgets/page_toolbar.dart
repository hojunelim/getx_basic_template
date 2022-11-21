import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageToolbar extends GetView {
  const PageToolbar({Key? key, this.position, required this.widget})
      : super(key: key);
  final Map<String, double>? position;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    Map<String, double> pos = position ?? {'top': 10, 'right': 10};
    return Positioned(
      top: pos['top'],
      left: pos['left'],
      right: pos['right'],
      bottom: pos['bottom'],
      child: widget,
    );
  }
}
