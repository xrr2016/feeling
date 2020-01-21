import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/theme_provider.dart';

class ThemeSetting extends StatefulWidget {
  static String routeName = '/theme-setting';

  @override
  _ThemeSettingState createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSetting> {
  int _currentIndex = 0;

  List<TableRow> _buildTable(List<Color> colors) {
    List<TableRow> _tableRows = [];

    for (int i = 0; i < colors.length; i++) {
      _tableRows.add(_buildTableRow(colors[i], i));
    }

    return _tableRows;
  }

  TableRow _buildTableRow(Color color, int index) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(12.0),
          leading: Container(
            width: 36,
            height: 36,
            color: color,
          ),
          trailing: _currentIndex == index ? Icon(Icons.check) : null,
          onTap: () {
            setState(() {
              _currentIndex = index;
              Provider.of<ThemeProvider>(context, listen: false)
                  .changeTheme(index);
            });
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _currentIndex =
        Provider.of<ThemeProvider>(context, listen: false).selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme setting'),
      ),
      body: Consumer<ThemeProvider>(
        builder: (_, theme, child) {
          return Column(
            children: <Widget>[
              SizedBox(height: 12.0),
              Table(
                children: _buildTable(theme.colors),
              ),
            ],
          );
        },
      ),
    );
  }
}
