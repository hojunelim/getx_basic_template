import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../commons/utils.dart';
import 'page_appbar.dart';
import 'page_bottombar.dart';

class PageWrap extends StatelessWidget {
  const PageWrap({
    super.key,
    required this.title,
    required this.child,
    this.toolbar,
    this.tabs,
    this.appbarLess = false,
    this.btLess = false,
    this.isSlivers = false,
    this.sliverOption = const {
      'pinned': true,
      'snap': true,
      'floating': true,
      'height': 160,
      'background': null,
    },
  });

  final Widget title;
  final Widget child;
  final List<Widget>? toolbar;
  final List<Widget>? tabs;
  final bool appbarLess;
  final bool btLess;
  final bool isSlivers;
  final Map<String, dynamic>? sliverOption;

  @override
  Widget build(BuildContext context) {
    bool isDark = context.theme.brightness == Brightness.dark;
    return Container(
      color: $u.colorBrightness(
          context.theme.colorScheme.background, 70 * (isDark ? -1 : 1)),
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
        body: isSlivers ? sliverApp(context) : basicApp(context),
        bottomNavigationBar: btLess ? null : const PageBottombar(),
      ),
    );
  }

  sliverApp(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          expandedHeight: sliverOption?['height'].toDouble() ?? 160,
          flexibleSpace: FlexibleSpaceBar(
            title: title,
            titlePadding: EdgeInsets.zero,
            background: sliverOption?['background'],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return child;
            },
          ),
        ),
      ],
    );
  }

  basicApp(BuildContext context) {
    return Container(child: child);
  }
}
