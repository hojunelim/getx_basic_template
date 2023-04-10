import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class StgCtrl {
  late GetStorage box;
  Future<StgCtrl> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String storageName = packageInfo.appName;

    await GetStorage.init(storageName);
    box = GetStorage(storageName);
    return this;
  }

  Future getBox(String boxName) async {
    return box.read(boxName);
  }

  Future getAll(String boxName) async {
    return await getBox(boxName) ?? [];
  }

  Future getOne(String boxName, String id) async {
    final result = await getBox(boxName);

    if (id != '' && result != null && result.length > 0) {
      return result.firstWhere((element) => element['id'] == id,
          orElse: () => {});
    } else {
      return null;
    }
  }

  Future<String> upsert(String boxName, String id, Map datas) async {
    print('upsert');
    List boxDatas = await getBox(boxName) ?? [];
    var result = await getOne(boxName, id);
    if (id == '' || result == null || result.length == 0) {
      datas['id'] =
          id == '' ? DateTime.now().millisecondsSinceEpoch.toString() : id;
      boxDatas.add(datas);
    } else {
      boxDatas[boxDatas.indexWhere((element) => element['id'] == id)] = datas;
    }
    box.write(boxName, boxDatas.toList());
    return datas['id'];
  }

  Future change(String boxName, List datas) async {
    print('change');
    box.write(boxName, datas);
  }

  Future delete(String boxName, String id) async {
    print('delete');
    List boxDatas = await getBox(boxName);
    boxDatas.removeWhere((element) => element['id'] == id);
    box.write(boxName, boxDatas.toList());
  }

  Future truncate(String boxName) async {
    print('truncate');
    box.write(boxName, []);
  }
}
