import 'package:flutter/material.dart';

class TextPad extends StatelessWidget {
  final String textbox;
  final double lrpad;
  TextPad(this.textbox, this.lrpad);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(lrpad, 25.0, lrpad, 25.0),
      child: Text(textbox),
    );
  }
}
