import 'package:flutter/material.dart';

class PageAppBar extends StatelessWidget with PreferredSizeWidget {
  const PageAppBar({super.key, required this.title, this.tabs, this.toolbar});

  final Widget title;
  final List<Widget>? toolbar;
  final List<Widget>? tabs;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      elevation: 0,
      actions: toolbar ?? [],
      backgroundColor: Colors.transparent,
      bottom: tabs != null
          ? TabBar(
              tabs: tabs ?? [],
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
