import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starshelper_app/utils/constant.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../../components/lessonitem.dart';
// utils
import '../../utils/helper.dart';
import '../../utils/global.dart';
// models
import '../../models/module.dart';
import '../../models/combindIndexes.dart';
import '../../models/lesson.dart';
import './indexlist.dart';
//

class TmtableListview extends StatefulWidget {
  TmtableListview(
      {Key key,
      this.isNewTable,
      this.tableName,
      this.TimeTable,
      this.usedIndex})
      : super(key: key);

  bool isNewTable = true;
  String tableName = "";
  Map<String, List<CLesson>> TimeTable = {};
  CcombinedIndexes usedIndex;

  @override
  _TmtableListviewState createState() => _TmtableListviewState();
}

class _TmtableListviewState extends State<TmtableListview>
    with SingleTickerProviderStateMixin {
  Map<String, List<CLesson>> timetable = {};
  CcombinedIndexes combinedIndex;

  String curDay = "Monday";
  List<String> FullDayes = [
    "Monday",
    "Tuesday",
    "Wednsday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  List<String> Dayes = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      setState(() {
        curDay = FullDayes[_tabController.index];
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        timetable = widget.TimeTable;
        combinedIndex = widget.usedIndex;
      });
    });
  }

  List<CLesson> sorted(List<CLesson> input) {
    input.sort((a, b) => a.Start_Time.compareTo(b.Start_Time));
    return input;
  }

  // regenerate timetable
  generate() {
    showLoaderDialog(
        context,
        "Please hold while we generate a timetable for you.",
        "This may take some time, depending on the number of modules.");
    generateTimeTable();
  }

  proceed() {
    gotoPage(context,
        IndexListPage(timeTable: timetable, combinedIndex: combinedIndex));
  }

  Future generateTimeTable() async {
    // for each combined index , create timetable
    Map<String, dynamic> result =
        await compute(getTimetableFromIndexes, Global().availCombinedIndexList);
    if (result != null) {
      Navigator.of(context, rootNavigator: true).pop();
      print("success");

      Map<String, List<CLesson>> genTimeTable = result["timetable"];
      Global().availCombinedIndexList = result["indexes"];
      setState(() {
        timetable = genTimeTable;
        combinedIndex = result["usedIndex"];
      });
    } else {
      print("failed");

      Navigator.of(context, rootNavigator: true).pop();
      showAlertDialog(context, null, () {
        Navigator.of(context, rootNavigator: true).pop();
      }, "Warning!", "There is no available timetables.");
    }
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: Dayes.map(
              (day) => SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: timetable[day] == null
                        ? []
                        : sorted(timetable[day])
                            .map((lessonItem) => LessonItem(
                                  data: lessonItem,
                                  onSelect: () {},
                                  isHideSwitch: true,
                                ))
                            .toList(),
                  )),
            ).toList(),
          ),
        ),
        TabBar(
            isScrollable: true,
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black45,
            tabs: Dayes.map((day) => Tab(
                  text: day,
                )).toList()),
        widget.isNewTable == true
            ? Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MaterialButton(
                            child: Text('Generate'),
                            color: C_colors.bg,
                            textColor: Colors.white,
                            onPressed: () {
                              generate();
                            },
                          ),
                        ],
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        proceed();
                      },
                      child: Icon(
                        Feather.arrow_right,
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
              )
            : Container(),
      ],
    );
  }
}
