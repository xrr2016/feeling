import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  static List<String> _languages = ['zh-CN', 'en-US'];
  List<String> get languages => _languages;

  String _language = _languages[0];
  String get language => _language;

  static List _regions = ['CN', 'US'];
  List<String> get regions => _regions;

  void changeLanguage(int index) async {
    if (index >= _languages.length || index < 0) {
      return;
    }

    _language = _languages[index];
    notifyListeners();
  }
}
