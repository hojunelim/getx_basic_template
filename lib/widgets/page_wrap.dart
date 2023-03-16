import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../commons/utils.dart';
import 'page_appbar.dart';
import 'page_bottombar.dart';

class PageWrap extends StatelessWidget {
  const PageWrap({
    Key? key,
    required this.title,
    required this.child,
    this.toolbar,
    this.tabs,
    this.floatingActionButton,
    this.appbarLess = false,
    this.btLess = false,
  }) : super(key: key);

  final Widget title;
  final Widget child;
  final List<Widget>? toolbar;
  final List<Widget>? tabs;
  final bool appbarLess;
  final bool btLess;
  final FloatingActionButton? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Utils.colorBrightness(context.theme.colorScheme.background, 35),
            context.theme.colorScheme.background,
            Utils.colorBrightness(context.theme.colorScheme.background, -35),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: appbarLess
            ? null
            : PageAppBar(
                title: title,
                toolbar: toolbar,
                tabs: tabs,
              ),
        body: Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: child),
        bottomNavigationBar: btLess ? null : const PageBottombar(),
      ),
    );
  }
}
