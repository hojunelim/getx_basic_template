import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageWrapBtless extends GetView {
  const PageWrapBtless(
      {Key? key,
      required this.title,
      required this.child,
      this.toolbar,
      this.tabs,
      this.floatingActionButton})
      : super(key: key);

  final String title;
  final Widget child;
  final List<Widget>? toolbar;
  final List<Widget>? tabs;
  final FloatingActionButton? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: toolbar ?? [],
        bottom: tabs != null
            ? TabBar(
                tabs: tabs ?? [],
              )
            : null,
      ),
      body: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: child),
      floatingActionButton: floatingActionButton,
    );
  }
}
