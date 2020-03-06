import 'package:hive/hive.dart';

class SettingBox {
  static Box box;
  static String boxName = 'setting-box';

  static int backgroundIndex = 0;
  static String backgroundIndexKey = 'background-index-key';

  static setBackgrountIndex(int index) async {
    backgroundIndex = index;
    await box.put(backgroundIndexKey, index);
  }

  init() async {
    box = await Hive.openBox(boxName);
    int index = box.get(backgroundIndexKey);

    if (index != null) {
      backgroundIndex = index;
    }
  }
}
