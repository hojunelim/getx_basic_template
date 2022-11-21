import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageWrapFull extends GetView {
  const PageWrapFull({Key? key, required this.title, required this.child})
      : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: child),
    );
  }
}
