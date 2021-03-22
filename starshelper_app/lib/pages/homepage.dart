import 'package:flutter/material.dart';
import 'Slidermain.dart';
import 'package:starshelper_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:starshelper_app/components/Images.dart';
import 'package:starshelper_app/components/Textbox.dart';

class HomePage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 110, 0, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  child: Imagebanners(
                      'assets/images/dark_logo_transparent_background.png')),
              Container(
                  decoration: BoxDecoration(color: Colors.blue[300]),
                  alignment: Alignment.topCenter,
                  child: TextPad("Welcome", 10.0)),
              Container(
                  decoration: BoxDecoration(color: Colors.blue[300]),
                  alignment: Alignment.topCenter,
                  child: TextPad("Planner", 10.0)),
              Container(
                  decoration: BoxDecoration(color: Colors.blue[300]),
                  alignment: Alignment.topCenter,
                  child: TextPad("Course Swap", 10.0)),
              Container(
                decoration: BoxDecoration(color: Colors.yellow),
                padding: const EdgeInsets.all(7.4),
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (context) => new Walkthrough()));
                    },
                    child: TextPad("Guide: How to use STARS Helper", 10.0)),
              ),
            ]),
      ),
    );
  }
}
