// import 'package:shared_preferences/shared_preferences.dart';

// class ThemePreferences {
//   static const String _selectedThemeKey = 'selected_index';

//   Future<int> getPreferredThemeIndex() async {
//     final preferences = await SharedPreferences.getInstance();

//     if (!preferences.containsKey(_selectedThemeKey)) return null;

//     final index = preferences.getInt(_selectedThemeKey);

//     return index;
//   }

//   Future savePreferredThemeIndex(int index) async {
//     final preferences = await SharedPreferences.getInstance();

//     await preferences.setInt(_selectedThemeKey, index);
//   }
// }
