import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageBottombar extends StatelessWidget {
  const PageBottombar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Diary',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'SHOP',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setup',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: context.theme.colorScheme.primary,
      unselectedItemColor: context.theme.colorScheme.onPrimary,
      onTap: (int index) {
        print('index: $index');
      },
    );
  }
}
