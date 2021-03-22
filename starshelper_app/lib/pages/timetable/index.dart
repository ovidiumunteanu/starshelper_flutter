import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starshelper_app/bloc.navigation_bloc/navigation_bloc.dart';
import '../../utils/constant.dart';
import '../../utils/helper.dart';
import './modules.dart'; // module list page
import './timetables.dart'; // timetable list page

class TTHomePage extends StatefulWidget with NavigationStates{
  TTHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TTHomePageState createState() => _TTHomePageState();
}

class _TTHomePageState extends State<TTHomePage> {
  
  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset(
            'assets/images/clock.png',
            width: scrWidth * 0.4,
            height: scrWidth * 0.4,
            fit: BoxFit.contain,
          ),
            Container( 
              child: MaterialButton(child: Text( 'TIMETABLE GENERATOR'),
                textColor: Colors.white,
                minWidth: scrWidth * 0.8,
                height: 50,
                onPressed: () {
                  gotoPage(context, ModulesPage());
              },),
              margin: EdgeInsets.only(top: 120),
              decoration: BoxDecoration(
                color: C_colors.bg,
                borderRadius: BorderRadius.circular(25),)
            ),
            Container(
              child: MaterialButton(child: Text( 'VIEW SAVED TIMETABLES'), 
                textColor: C_colors.bg,
                minWidth: scrWidth * 0.8,
                height: 50,
                onPressed: () {
                  gotoPage(context, TTablesPage());
              },),
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(style: BorderStyle.solid, color: C_colors.bg),
                borderRadius: BorderRadius.circular(25),)
            ),
            
          ],
        ),
        padding: EdgeInsets.only(bottom: 150),
      )),
    );
  }
}
