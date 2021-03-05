import 'package:flutter/material.dart';
import 'package:starshelper_app/utils/constant.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../components/moduleitem.dart';
import '../models/module.dart';
import '../apis/modules.dart';

class TTablesPage extends StatefulWidget {
  TTablesPage({Key key}) : super(key: key);

  final String title = "Saved Timetables";

  @override
  _TTablesPageState createState() => _TTablesPageState();
}

class _TTablesPageState extends State<TTablesPage> {
  final ctrlEdit = TextEditingController();

  int selectedCount = 0;
  List<String> table_list = ['Timetable 1', 'Timetable 2', 'Timetable 3', 'Timetable 4', 'Timetable 5', 'Timetable 6', 'Timetable 7'];

  @override
  void initState()  {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: C_colors.bg,
      ),
      body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.black12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: 
              SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: 
                  Container(
                    child: Column(
                      children: table_list.map((item) => Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Material(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(item, style: TextStyle(color: Colors.black87), textAlign: TextAlign.start, ),
                                onTap: (){},
                                horizontalTitleGap: 20,
                            ),),
                        ],),
                        padding: EdgeInsets.only(top: 4, bottom: 4, left: 3, right: 3),
                      ),).toList()
                    ,),
                  ),
              ),
              
            ),
            Container(
              width: double.infinity,
              child: Column(children: [
                Text("Select to view/edit the saved timetables.", style: TextStyle(color: Colors.white),)
              ],),
              padding: EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
              decoration: BoxDecoration(color: Colors.black38),
            ),
          ],
        ),
      ),
    );
  }
}
