import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/home_grid_cell_model.dart';

class HomeGridCellData extends GetxService {
  static getAll() {
    int index = 0;
    return [
      HomeGridCellModel(
        color: Colors.red,
        rowStart: 0,
        rowSpan: 2,
        index: index++,
        href: '/progress',
        content: 'progress',
      ),
      HomeGridCellModel(
        color: Colors.blue,
        index: index++,
        href: '/menu',
        content: 'menu',
      ),
      HomeGridCellModel(
        color: Colors.yellow,
        index: index++,
        href: '/person',
        content: 'person',
      ),
      HomeGridCellModel(
        color: Colors.green,
        index: index++,
        href: '/diary',
        content: 'diary',
      ),
      HomeGridCellModel(
        color: Colors.purple,
        index: index++,
        href: '/setup',
        content: 'setup',
      ),
    ];
  }
}
