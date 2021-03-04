import 'package:flutter/material.dart';
import '../utils/constant.dart';
import '../utils/helper.dart';
import './modules.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                              color: C_colors.bg,
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: MaterialButton(child: Text( 'TIMETABLE GENERATOR'),
                color: C_colors.btnbg,
                textColor: Colors.white,
                minWidth: scrWidth * 0.8,
                height: 50,
                onPressed: () {
                  gotoPage(context, ModulesPage());
              },),
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              child: MaterialButton(child: Text( 'VIEW SAVED TIMETABLES'), 
                color: C_colors.btnbg,
                textColor: Colors.white,
                minWidth: scrWidth * 0.8,
                height: 50,
                onPressed: () {
              },),
              margin: EdgeInsets.only(top: 20),
            ),
            
          ],
        ),
        padding: EdgeInsets.only(bottom: 150),
      )),
    );
  }
}
