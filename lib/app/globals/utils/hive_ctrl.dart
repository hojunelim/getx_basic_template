import 'package:hive_flutter/hive_flutter.dart';

class HiveCtrl {
  late Box box;

  Future init({String hiveName = 'hive_box'}) async {
    try {
      box = Hive.box(hiveName);
    } catch (error) {
      box = await Hive.openBox(hiveName);
      print(error);
    }
  }

  Future getBox(String boxName) async {
    return box.get(boxName);
  }

  Future getAll(String boxName) async {
    return getBox(boxName);
  }

  Future getOne(String boxName, String id) async {
    final result = await getBox(boxName);

    if (id != '') {
      return result.firstWhere((element) => element.id == id);
    } else {
      return null;
    }
  }

  Future<String> upsert(String boxName, String id, dynamic datas) async {
    print('upsert');
    List boxDatas = await getBox(boxName) ?? [];
    var result = await getOne(boxName, id);
    if (id == '' || result == null) {
      datas.id = DateTime.now().millisecondsSinceEpoch.toString();
      boxDatas.add(datas);
    } else {
      boxDatas[boxDatas.indexWhere((element) => element.id == id)] = datas;
    }
    box.put(boxName, boxDatas.toList());
    return datas.id;
  }

  Future delete(String boxName, String id) async {
    print('delete');
    List boxDatas = await getBox(boxName);
    boxDatas.removeWhere((element) => element.id == id);
    box.put(boxName, boxDatas.toList());
  }
}
