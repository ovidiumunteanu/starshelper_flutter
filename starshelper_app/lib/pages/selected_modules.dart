import 'package:flutter/material.dart';
import 'package:starshelper_app/utils/constant.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../models/module.dart';

class SelectedModulesPage extends StatefulWidget {
  SelectedModulesPage({Key key, this.module_list}) : super(key: key);

  final String title = "Selected Modules";
  List<CModule> module_list = [];

  @override
  _SelectedModulesPageState createState() => _SelectedModulesPageState();
}

class _SelectedModulesPageState extends State<SelectedModulesPage> {
  final ctrlEdit = TextEditingController();

  @override
  void initState() {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: 
                  Container(
                    child: Column(
                      children: widget.module_list.map((item) => Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Material(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(item.Module_Code, style: TextStyle(color: Colors.black87), textAlign: TextAlign.start, ),
                                subtitle: Text(item.Module_Name, style: TextStyle(color: Colors.black87), textAlign: TextAlign.start, ),
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
              child: Column(
                children: [Text("Tap on the modules to see the available index and timeslots.", style: TextStyle(color: Colors.white, fontSize: 12),)],
              ),
              padding:
                  EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
              decoration: BoxDecoration(color: Colors.black26),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.module_list.length}" + " Modules selected",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          "Tap the plus to proceed",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Feather.plus,
                      color: Colors.white,
                      size: 20,
                    ),
                    backgroundColor: C_colors.btnbg,
                  ),
                ],
              ),
              padding:
                  EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
              decoration: BoxDecoration(color: C_colors.bg),
            ),
          ],
        ),
      ),
    );
  }
}
