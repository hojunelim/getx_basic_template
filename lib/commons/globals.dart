import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get/get.dart';
import '../services/app_translations.dart';
import 'stg_ctrl.dart';

class Globals extends GetxService {
  final db = Get.find<StgCtrl>();

  final appName = 'SuperLab';
  final appTitle = 'superlab';
  final _language = 'en_US'.obs;
  final RxInt _theme = 0.obs;
  final RxString _concept = 'mallardGreen'.obs;

  //getters
  String get language => _language.value;
  int get theme => _theme.value;
  String get concept => _concept.value;
  get languageList => AppTranslations.languageCodes;

  Map<String, String> get adMobKeys {
    if (GetPlatform.isAndroid) {
      return adMobKeysAndroid;
    } else if (GetPlatform.isIOS) {
      return adMobKeysIos;
    } else {
      return {};
    }
  }

  final Map<String, String> adMobKeysAndroid = {
    'Banner': 'ca-app-pub-3940256099942544/6300978111',
    'Native': 'ca-app-pub-3940256099942544/2247696110',
    'Interstitial': 'ca-app-pub-3940256099942544/1033173712',
    'Rewarded': 'ca-app-pub-3940256099942544/5224354917',
    'RewardedInterstitial': 'ca-app-pub-3940256099942544/5354046379',
  };

  final Map<String, String> adMobKeysIos = {
    'Banner': 'ca-app-pub-3940256099942544/2934735716',
    'Native': 'ca-app-pub-3940256099942544/2247696110',
    'Interstitial': 'ca-app-pub-3940256099942544/4411468910',
    'Rewarded': 'ca-app-pub-3940256099942544/1712485313',
    'RewardedInterstitial': 'ca-app-pub-3940256099942544/6978759866',
  };

  final Map<String, FlexScheme> conceptList = {
    'blue': FlexScheme.blue,
    'indigo': FlexScheme.indigo,
    'redWine': FlexScheme.redWine,
    'purpleBrown': FlexScheme.purpleBrown,
    'green': FlexScheme.green,
    'money': FlexScheme.money,
    'jungle': FlexScheme.jungle,
    'greyLaw': FlexScheme.greyLaw,
    'amber': FlexScheme.amber,
    'vesuviusBurn': FlexScheme.vesuviusBurn,
    'shark': FlexScheme.shark,
    'damask': FlexScheme.damask,
    'mallardGreen': FlexScheme.mallardGreen,
    'sanJuanBlue': FlexScheme.sanJuanBlue,
    'rosewood': FlexScheme.rosewood,
    'Baseline': FlexScheme.materialBaseline,
    'verdunHemlock': FlexScheme.verdunHemlock,
    'hippieBlue': FlexScheme.hippieBlue,
    'aquaBlue': FlexScheme.aquaBlue,
    'brandBlue': FlexScheme.brandBlue,
    'deepBlue': FlexScheme.deepBlue,
    'mandyRed': FlexScheme.mandyRed,
    'red': FlexScheme.red,
    'mango': FlexScheme.mango,
    'ebonyClay': FlexScheme.ebonyClay,
    'barossa': FlexScheme.barossa,
    'bahamaBlue': FlexScheme.bahamaBlue,
    'outerSpace': FlexScheme.outerSpace,
    'blueWhale': FlexScheme.blueWhale,
    'blumineBlue': FlexScheme.blumineBlue,
    'flutterDash': FlexScheme.flutterDash,
    'dellGenoa': FlexScheme.dellGenoa,
  };

  setAttr(String key, value) {
    switch (key) {
      case 'language':
        _language.value = value;
        Get.updateLocale(AppTranslations.locale(value));
        break;
      case 'theme':
        _theme.value = value;
        break;
      case 'concept':
        _concept.value = value;
        break;
      default:
        print("setAttr: $key, $value");
        break;
    }
    dbSave();
  }

  Future dbSave() async {
    print("Globals dbSave");
    Map<String, dynamic> data = {
      'id': 'setting',
      'language': _language.value,
      'theme': _theme.value,
      'concept': _concept.value,
    };
    String id = await db.upsert('setting', 'setting', data);
    print("id: $id");
  }

  Future dbSync() async {
    print("Globals dbSync");
    Map? data = await db.getOne('setting', 'setting');
    print(data);
    if (data != null) {
      data.forEach((key, value) {
        print("key: $key, value: $value");
        setAttr(key, value);
      });
    }
  }

  Future<Globals> init() async {
    print("Globals onInit");
    await dbSync();
    return this;
  }
}
