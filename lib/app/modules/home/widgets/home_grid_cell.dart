import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';

import '../../../data/model/home_grid_cell_model.dart';

class HomeGridCell extends GetView {
  const HomeGridCell({Key? key, required this.item, required this.child})
      : super(key: key);
  final HomeGridCellModel item;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GridPlacement(
      columnStart: item.columnStart,
      columnSpan: item.columnSpan,
      rowStart: item.rowStart,
      rowSpan: item.rowSpan,
      child: Card(
        color: item.color,
        elevation: 5,
        child: InkWell(
          onTap: () {
            if (item.href.isNotEmpty) {
              Get.toNamed(item.href);
            }
          },
          child: Container(
              width: Get.width,
              height: Get.height,
              alignment: Alignment.center,
              child: child),
        ),
      ),
    );
  }
}
