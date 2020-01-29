import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/story.dart';
import '../../model/movie.dart';

class StoryBox {
  Box box;
  static String name = 'storyBox';

  init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Story>(StoryAdapter());
    Hive.registerAdapter<Movie>(MovieAdapter());
    box = await Hive.openBox<Story>(name);
  }
}
