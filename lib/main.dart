import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './routes.dart';
import './ui/index/index_screen.dart';
import './provider/theme_provider.dart';
import './provider/locale_provider.dart';
import './data/local/translate_preferences.dart';

void main() async {
  await DotEnv().load('.env');
  final delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en', 'zh'],
    preferences: TranslatePreferences(),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        LocalizedApp(delegate, MyApp()),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, theme, child) {
            return MaterialApp(
              title: 'Flin',
              theme: ThemeData(
                textTheme: GoogleFonts.robotoTextTheme().apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                  decorationColor: Colors.white,
                ),
              ),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                localizationDelegate
              ],
              supportedLocales: localizationDelegate.supportedLocales,
              locale: localizationDelegate.currentLocale,
              debugShowCheckedModeBanner: false,
              home: child,
              routes: routes,
            );
          },
          child: IndexScreen(),
        ),
      ),
    );
  }
}
