import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:starshelper_app/utils/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:starshelper_app/bloc.navigation_bloc/navigation_bloc.dart';
import '../../models/module.dart';
import '../../models/combindIndexes.dart';
import '../../models/lesson.dart';
import '../../models/index.dart';
import '../../models/timetable.dart';
import '../../utils/helper.dart';
import '../../utils/global.dart';
import '../../apis/timetables.dart';
import './index.dart';
import '../../sidebar/sidebar_layout.dart';

class IndexListPage extends StatefulWidget {
  IndexListPage({Key key, this.timeTable, this.combinedIndex})
      : super(key: key);

  final String title = "Index List";
  Map<String, List<CLesson>> timeTable;
  CcombinedIndexes combinedIndex;

  @override
  _IndexListPageState createState() => _IndexListPageState();
}

class _IndexListPageState extends State<IndexListPage> {
  @override
  void initState() {
    super.initState();
  }

  // when click bottom right button
  proceed() {
    showSaveTimeTableDialog(context, () {
      Navigator.of(context, rootNavigator: true).pop();
    }, (String tableName) {
      if (tableName.isEmpty) {
        showAlertDialog(context, null, () {
          Navigator.of(context, rootNavigator: true).pop();
        }, "Warning!", "Enter tablename!");
        return;
      }
      // show loading dialog
      showLoaderDialog(context, "Saving timetable...", null);
      saveTimeTable(tableName);
    });
  }

  // save timetable to db with entered tablename
  saveTimeTable(String tableName) {
    api_timetables
        .createData(CTimeTable(tableName, widget.timeTable))
        .then((res) {
      Navigator.of(context, rootNavigator: true).pop(); // close loading
      Navigator.of(context, rootNavigator: true).pop(); // close timetable modal
      showAlertDialog(context, null, () {
        Navigator.of(context, rootNavigator: true).pop();
        // go home page
        Global().appData["sidebar_initpage"] = TTHomePage(title: 'Home',);
        gotoPageReplacement(context, SideBarLayout());
      }, "Success!", "Your tablename saved!");
    }).catchError((err) {
      Navigator.of(context, rootNavigator: true).pop(); // close loading
      showAlertDialog(context, null, () {
        Navigator.of(context, rootNavigator: true).pop();
      }, "Error!", "Couldn't save this tablename!");
      print('save timetable error $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: C_colors.bg,
      ),
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Column(
                      children: widget.combinedIndex.indexModules
                          .map(
                            (indexItem) => Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Text(
                                        indexItem.lessons[0].Module_Code +
                                            " - " +
                                            indexItem.lessons[0].Module_Name,
                                        style: TextStyle(color: Colors.black87),
                                        textAlign: TextAlign.start,
                                      ),
                                      subtitle: Text(
                                        indexItem.index,
                                        style: TextStyle(color: Colors.black87),
                                        textAlign: TextAlign.start,
                                      ),
                                      onTap: () {},
                                      horizontalTitleGap: 20,
                                    ),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.only(
                                  top: 4, bottom: 4, left: 3, right: 3),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        proceed();
                      },
                      child: Icon(
                        Feather.arrow_down,
                        color: Colors.white,
                        size: 20,
                      ),
                      backgroundColor: C_colors.bg,
                    ),
                  ],
                ),
                padding:
                    EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white, boxShadow: [BoxShadow()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
