import 'package:Feeling/store/background_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Layout extends StatelessWidget {
  final Widget child;

  const Layout({this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<BackgroundProvider>(
      builder: (context, background, child) {
        return DecoratedBox(
          child: child,
          decoration: BoxDecoration(
            // gradient: background.values[1],
            color: Colors.grey[200],
          ),
        );
      },
      child: child,
    );
  }
}
