import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../globals/utils/native_splash.dart';
import '../../globals/widgets/page_wrap.dart';
import 'home_controller.dart';
import 'widgets/home_grid_cell.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());

  @override
  build(BuildContext context) {
    NativeSplash.splashRemove();

    return PageWrap(
        title: 'Home',
        child: LayoutGrid(
          columnSizes: [1.fr, 1.fr],
          rowSizes: [1.fr, 1.fr, 1.fr],
          columnGap: 10,
          rowGap: 10,
          children: [
            for (var cell in controller.getGridCells())
              HomeGridCell(
                item: cell,
                //child: Text(cell.content),
                child: Text(cell.content),
              ),
          ],
        ));
  }
}
