import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './routes.dart';
import './ui/index/index_screen.dart';
import './provider/theme_provider.dart';
import './provider/locale_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: theme.color,
            ),
            home: IndexScreen(),
            routes: routes,
          );
        },
      ),
    );
  }
}
