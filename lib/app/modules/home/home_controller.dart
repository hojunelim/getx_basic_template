import 'package:get/get.dart';
import '../../data/local/home_grid_cell_data.dart';

class HomeController extends GetxController {
  getGridCells() => HomeGridCellData.getAll();
}
