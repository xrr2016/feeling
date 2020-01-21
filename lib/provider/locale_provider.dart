import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  static List _languages = ['zh-CN', 'en-US'];

  String _language = _languages[0];

  get language => _language;

  get languages => _languages;

  void changeLanguage(int index) async {
    if (index >= _languages.length || index < 0) {
      return;
    }

    _language = _languages[index];
    notifyListeners();
  }
}
