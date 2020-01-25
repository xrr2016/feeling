import 'package:flutter/material.dart';

class TextTag extends StatelessWidget {
  final String text;

  const TextTag(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Text(text, style: TextStyle(fontSize: 14.0)),
    );
  }
}
