import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import './theme_setting/theme_setting.dart';

class SettingScreen extends StatelessWidget {
  static String routeName = '/setting-screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, theme, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Settinng'),
          ),
          backgroundColor: theme.backgroundColor,
          body: child,
        );
      },
      child: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          Table(
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                children: [
                  Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.color_lens),
                        title: Text('Theme setting'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () => Navigator.pushNamed(
                          context,
                          ThemeSetting.routeName,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
