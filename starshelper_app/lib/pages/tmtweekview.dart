import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starshelper_app/utils/constant.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import '../components/lessonitem.dart';
// utils
import '../utils/helper.dart';
import '../utils/global.dart';
// models
import '../models/module.dart';
import '../models/combindIndexes.dart';
import '../models/lesson.dart';
import './indexlist.dart';
//
import '../components/stepper.dart';
import '../components/paginationBtn.dart';

class OneDaytimeslots extends StatefulWidget {
  OneDaytimeslots({Key key, this.gridH, this.lessons}) : super(key: key);

  double gridH;
  List<CLesson> lessons;

  @override
  _OneDaytimeslotsState createState() => _OneDaytimeslotsState();
}

class _OneDaytimeslotsState extends State<OneDaytimeslots> {
  double stepOnemin() {
    return widget.gridH / 60;
  }

  Widget getEmptyGridItem(double height) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(width: 1, color: Colors.black26),
              left: BorderSide(width: 1, color: Colors.black26))),
      child: Container(),
      padding: EdgeInsets.only(top: 0, bottom: 0),
    );
  }

  Widget getLessonGridItem(double height, String text) {
    // return Container(
    // width: double.infinity,
    // height: height,
    //           decoration: BoxDecoration(
    //               color: Colors.blueAccent,
    //               border: Border(
    //                   top: BorderSide(
    //                       width: 1, color: Colors.black26),
    //                   left: BorderSide(
    //                       width: 1, color: Colors.black26))),
    //           child: Text(text, style: TextStyle(fontSize: 10),),
    //           padding: EdgeInsets.only(top: 0, bottom: 0),
    //         );
    return Material(
        child: Ink(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.amber[300],
        border: Border(
            top: BorderSide(width: 1, color: Colors.black26),
            left: BorderSide(width: 1, color: Colors.black26)),
      ),
      child: InkWell(
          // customBorder: const CircleBorder(),
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(child: 
            Column(
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            )
            ,) 
            
          )),
    ));
  }

  List<CLesson> sorted(List<CLesson> input) {
    if (input == null) return [];
    input.sort((a, b) => a.Start_Time.compareTo(b.Start_Time));
    return input;
  }

  Map<String, int> getHM(CLesson lesson, bool isStart) {
    if (isStart) {
      int h = ((lesson.Start_Time - lesson.Start_Time % 100) / 100).round();
      int m = lesson.Start_Time % 100;
      return {"h": h, "m": m};
    } else {
      int h = ((lesson.End_Time - lesson.End_Time % 100) / 100).round();
      int m = lesson.End_Time % 100;
      return {"h": h, "m": m};
    }
  }

  List<Widget> getTimsSlots() {
    List<CLesson> lessons = sorted(widget.lessons);
    int lastslot_h = 0;
    int lastslot_m = 0;
    List<Widget> list = [];
    for (CLesson lesson in lessons) {
      int lesson_start_hour = getHM(lesson, true)["h"];
      int lesson_start_min = getHM(lesson, true)["m"];
      int lesson_end_hour = getHM(lesson, false)["h"];
      int lesson_end_min = getHM(lesson, false)["m"];

      if (lesson_start_hour > lastslot_h) {
        if (lastslot_m > 0) {
          list.add(getEmptyGridItem(stepOnemin() * (60 - lastslot_m)));
          for (int i = lastslot_h + 1; i < lesson_start_hour; i++) {
            list.add(getEmptyGridItem(widget.gridH));
          }
        } else {
          for (int i = lastslot_h; i < lesson_start_hour; i++) {
            list.add(getEmptyGridItem(widget.gridH));
          }
        }
        list.add(getEmptyGridItem(stepOnemin() * lesson_start_min));
      } else {
        if (lesson_end_min - lastslot_m > 0) {
          list.add(
              getEmptyGridItem(stepOnemin() * (lesson_end_min - lastslot_m)));
        }
      }

      // add lesson item
      int tmp_end_mins = lesson_end_hour * 60 + lesson_end_min;
      int tmp_start_mins = lesson_start_hour * 60 + lesson_start_min;
      double lesson_height = stepOnemin() * (tmp_end_mins - tmp_start_mins);
      list.add(getLessonGridItem(
          lesson_height, "index: " + lesson.index.toString() + "\n\n" + lesson.Module_Code + "-" + lesson.Module_Name));
      //
      lastslot_h = lesson_end_hour;
      lastslot_m = lesson_end_min;
    }

    if (lastslot_m > 0) {
      list.add(getEmptyGridItem(stepOnemin() * (60 - lastslot_m)));
      for (int i = lastslot_h + 1; i < 24; i++) {
        list.add(getEmptyGridItem(widget.gridH));
      }
    } else {
      for (int i = lastslot_h; i < 24; i++) {
        list.add(getEmptyGridItem(widget.gridH));
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: getTimsSlots());
  }
}

class TmtableWeekView extends StatefulWidget {
  TmtableWeekView(
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
  _TmtableWeekViewState createState() => _TmtableWeekViewState();
}

class _TmtableWeekViewState extends State<TmtableWeekView>
    with SingleTickerProviderStateMixin {
  Map<String, List<CLesson>> timetable = {};
  CcombinedIndexes combinedIndex;
  int colnum = 7;
  int startcol = 0;
 double gridH = 70;
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
  List<String> Times = [
    "12 am",
    "1 am",
    "2 am",
    "3 am",
    "4 am",
    "5 am",
    "6 am",
    "7 am",
    "8 am",
    "9 am",
    "10 am",
    "11 am",
    "12 pm",
    "1 pm",
    "2 pm",
    "3 pm",
    "4 pm",
    "5 pm",
    "6 pm",
    "7 pm",
    "8 pm",
    "9 pm",
    "10 pm",
    "11 pm"
  ];
  TabController _tabController;

  ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 70.0 * 8,
    keepScrollOffset: true,
  );

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

  List<String> getShowDays() {
    List<String> showdays = [];
    for (int i = startcol; i < startcol + colnum; i++) {
      showdays.add(Dayes[i]);
    }
    return showdays;
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
    double slotlabelW = 54;
    double gridW = (scrWidth - slotlabelW) / colnum;
    
    return Column(
      children: <Widget>[
        // table controller
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(children: [
            Text(
              "Show : ",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF65A34A)),
            ),
            CustomStepper(
              lowerLimit: 2,
              upperLimit: 7,
              stepValue: 1,
              iconSize: 26,
              value: colnum,
              onChange: (value) {
                print(value);
                setState(() {
                  colnum = value;
                });
              },
            ),
            Expanded(child: Container()),
            PaginationBtn(
              onPrev: () {
                setState(() {
                  startcol = startcol > 0 ? startcol - 1 : startcol;
                });
              },
              onNext: () {
                setState(() {
                  startcol = startcol + colnum < 7 ? startcol + 1 : startcol;
                });
              },
              isPrevDisabled: startcol <= 0,
              isNextDisabled: (startcol + colnum >= 7),
            )
          ]),
          decoration:
              BoxDecoration(color: Colors.white, boxShadow: [BoxShadow()]),
        ),
        // table header
        Container(
          child: Row(children: [
            Container(
              width: slotlabelW,
              decoration: BoxDecoration(color: Colors.black12),
              child: Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              padding: EdgeInsets.only(top: 12, bottom: 10),
            ),
            for (String day in getShowDays())
              Container(
                width: gridW,
                decoration: BoxDecoration(color: Colors.black12),
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
                padding: EdgeInsets.only(top: 12, bottom: 10),
              )
          ]),
          decoration:
              BoxDecoration(color: Colors.white, boxShadow: [BoxShadow()]),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Row(
              children: [
                Container(
                  width: slotlabelW * 3 / 4,
                  decoration: BoxDecoration(color: Colors.amberAccent),
                  child: Column(
                    children: Times.map((time) => Container(
                          width: double.infinity,
                          height: gridH,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                            margin: EdgeInsets.only(right: 2),
                            child: Text(
                              time,
                              textAlign: TextAlign.right,
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                        )).toList(),
                  ),
                  // padding: EdgeInsets.only(top: 12, bottom: 10),
                ),
                Container(
                  margin: EdgeInsets.only(top: 14),
                  width: slotlabelW / 4,
                  decoration: BoxDecoration(color: Colors.amberAccent),
                  child: Column(
                    children: Times.map((time) => Container(
                          width: double.infinity,
                          height: gridH,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top:
                                    BorderSide(width: 1, color: Colors.black26),
                              )),
                          child: Container(),
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                        )).toList(),
                  ),
                  // padding: EdgeInsets.only(top: 12, bottom: 10),
                ),
                for (String day in getShowDays())
                  Container(
                      margin: EdgeInsets.only(top: 14),
                      width: gridW,
                      decoration: BoxDecoration(color: Colors.amberAccent),
                      child:
                          OneDaytimeslots(gridH: gridH, lessons: timetable[day])
                      // padding: EdgeInsets.only(top: 12, bottom: 10),
                      )
              ],
            ),
          ),
        ),
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
