import 'package:hive/hive.dart';

class StoryBox {
  static String name = 'storyBox';

  init() async {
    var storyBox = await Hive.openBox(name);
    return storyBox;
  }
}
