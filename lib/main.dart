import 'package:Feeling/provider/theme_provider.dart';
import 'package:bot_toast/bot_toast.dart';
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
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Tmdb.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return BotToastInit(
            child: MaterialApp(
              title: 'Feeling',
              theme: ThemeData(
                fontFamily: 'AlibabaSans',
                primarySwatch: theme.color,
              ),
              navigatorObservers: [BotToastNavigatorObserver()],
              debugShowCheckedModeBanner: false,
              home: child,
              routes: routes,
            ),
          );
        },
        child: IndexScreen(),
      ),
    );
  }
}
