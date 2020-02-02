import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './routes.dart';
import './data/box/story_box.dart';
import './ui/index/index_screen.dart';
import './provider/theme_provider.dart';
import './provider/locale_provider.dart';

void main() async {
  await DotEnv().load('.env');
  await StoryBox().init();
  // final delegate = await LocalizationDelegate.create(
  //   fallbackLocale: 'en',
  //   supportedLocales: ['en', 'zh'],
  //   preferences: TranslatePreferences(),
  // );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MyApp(),
        // LocalizedApp(delegate, MyApp()),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final localizationDelegate = LocalizedApp.of(context).delegate;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return BotToastInit(
            child: MaterialApp(
              title: 'Feeling',
              theme: ThemeData(fontFamily: 'AlibabaSans'),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                // localizationDelegate
              ],
              // supportedLocales: localizationDelegate.supportedLocales,
              navigatorObservers: [BotToastNavigatorObserver()],
              // locale: localizationDelegate.currentLocale,
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
