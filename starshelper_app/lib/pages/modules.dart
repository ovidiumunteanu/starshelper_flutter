import 'package:flutter/material.dart';
import 'package:starshelper_app/models/index.dart';
import 'package:starshelper_app/utils/constant.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../components/searchbar.dart';
import '../components/moduleitem.dart';
// apis
import '../apis/modules.dart';
// utils
import '../utils/helper.dart';
// pages
import './selected_modules.dart';
// models
import '../models/module.dart';
import '../models/lesson.dart';

class ModulesPage extends StatefulWidget {
  ModulesPage({Key key}) : super(key: key);

  final String title = "Module List";

  @override
  _ModulesPageState createState() => _ModulesPageState();
}

class _ModulesPageState extends State<ModulesPage> {
  final ctrlEdit = TextEditingController();

  bool isloading = false;
  List<CModule> selectedModules = [];
  List<CModule> allModules = [];
  List<CModule> showModules = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isloading = true;
    });

    List<CModule> tmpAllModules = [];
    api_modules.fetchAll().then((list) {
      // group modules
      Map<String, List<CLesson>> tmp_groups = {};
      for (CLesson item in list) {
        if (tmp_groups[item.Module_Code] == null) {
          tmp_groups[item.Module_Code] = [];
        }
        tmp_groups[item.Module_Code].add(item);
      }

      for (String moduleCode in tmp_groups.keys) {
        Map<String, List<CLesson>> tmp_groups_index = {};
        for (CLesson item in tmp_groups[moduleCode]) {
          if (tmp_groups_index[item.index.toString()] == null) {
            tmp_groups_index[item.index.toString()] = [];
          }
          tmp_groups_index[item.index.toString()].add(item);
        }

        List<CIndex> tmpIndexes = [];
        for (String index in tmp_groups_index.keys) {
          CIndex tmpIndex = CIndex(index, tmp_groups_index[index]);
          tmpIndexes.add(tmpIndex);
        }

        tmpAllModules.add(CModule(
            moduleCode, tmp_groups[moduleCode][0].Module_Name, tmpIndexes));
      }

      setState(() {
        allModules = tmpAllModules;
        showModules = tmpAllModules;
        isloading = false;
      });
    }).catchError((err) {
      print('bbb $err');
      setState(() {
        isloading = false;
      });
    });
  }

  onSelectItem(bool val, CModule item) {
    List<CModule> tmpModules = [];
    tmpModules.addAll(selectedModules);
    if (val == true) {
      tmpModules.add(item);
      setState(() {
        selectedModules = tmpModules;
      });
    } else {
      tmpModules.remove(item);
      setState(() {
        selectedModules = tmpModules;
      });
    }
  }

  proceed() {
    if(selectedModules.length == 0) {return;}
    gotoPage(context, SelectedModulesPage(selectedAllmodules: selectedModules));
  }

  searchModule(String text){
    if(text.isEmpty) {
      setState(() {
        showModules = allModules;
      });
      return;
    }
    String findText = text.toLowerCase();
    List<CModule> tmpModules = [];
    for(CModule item in allModules) {
      String searchData = (item.Module_Code + item.Module_Name).toLowerCase();
      if(searchData.contains(findText) == true) {
        tmpModules.add(item);
      }
    }
    setState(() {
      showModules = tmpModules;
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: C_colors.grey,
              ),
              child: SearchBar(
                width: scrWidth * 0.9,
                placeholder: "Search by Module Name/Code",
                onChange: (String text) {searchModule(text);},
              ),
              padding: EdgeInsets.all(8),
            ),
            Expanded(
              child: SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: isloading
                        ? [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          ]
                        : showModules
                            .map((moduleItem) => ModuleItem(
                                data: moduleItem, onSelect: onSelectItem))
                            .toList(),
                  )),
            ),
            Container(
              child: Column(
                children: [Text("Select the modules required...")],
              ),
              margin: EdgeInsets.only(bottom: 12),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${selectedModules.length}" + " Modules selected",
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
                    onPressed: () {
                      proceed();
                    },
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
