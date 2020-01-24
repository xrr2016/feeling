import 'package:flutter/material.dart';

import './ui/setting/setting_screen.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

final routes = {
  SettingScreen.routeName: (_) => SettingScreen(),
  '/web': (context) {
    final String url = ModalRoute.of(context).settings.arguments;

    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title: Text(url),
      ),
      withZoom: true,
      withLocalStorage: false,
      hidden: false,
      initialChild: Container(
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  },
};
