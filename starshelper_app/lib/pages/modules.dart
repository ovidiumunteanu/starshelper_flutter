import 'package:flutter/material.dart';
import 'package:starshelper_app/utils/constant.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../components/searchbar.dart';
import '../components/moduleitem.dart';
import '../models/module.dart';
import '../apis/modules.dart';
import './selected_modules.dart';
import '../utils/helper.dart';

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
  List<CModule> module_list = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      isloading = true;
    });
    api_modules.fetchAll().then((list) {
      setState(() {
        module_list = list;
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
                        : module_list
                            .map((item) =>
                                ModuleItem(data: item, onSelect: onSelectItem))
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
                      gotoPage(context, SelectedModulesPage(module_list: selectedModules));
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
