import 'package:Feeling/const/app_info.dart';
import 'package:Feeling/data/box/setting_box.dart';
import 'package:Feeling/service/tmdb.dart';
import 'package:Feeling/store/background_provider.dart';
import 'package:Feeling/store/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import './routes.dart';
// import './data/network/tmdb.dart';
import './data/box/story_box.dart';
import './ui/index/index_screen.dart';

void main() async {
  await DotEnv().load('.env');
  await StoryBox().init();
  await SettingBox().init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Tmdb.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<BackgroundProvider>(
          create: (_) => BackgroundProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: AppInfo.title,
            theme: ThemeData(fontFamily: 'AlibabaSans'),
            debugShowCheckedModeBanner: false,
            home: child,
            routes: routes,
          );
        },
        child: IndexScreen(),
      ),
    );
  }
}
