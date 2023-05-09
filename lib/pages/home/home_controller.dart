import 'package:get/get.dart';

import '../../commons/globals.dart';
import '../../services/ad_service.dart';

class HomeController extends GetxController {
  final G = Get.find<Globals>();
  final adService = Get.find<AdService>();

  @override
  onInit() {
    ctrlInit();
    super.onInit();
  }

  ctrlInit() async {
    adService.loadBanner(G.adMobKeys['Banner']!, 'BANNER');
  }
}
