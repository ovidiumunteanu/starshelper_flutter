import '../models/module.dart';
import '../models/combinedIndexes.dart';

class Global {
  static final Global _global = Global._internal();

  factory Global() {
    return _global;
  }

  Global._internal();

  var appData = new Map<String, dynamic>();

  List<CModule> selectedAllModules = [];
  List<CcombinedIndexes> availCombinedIndexList = [];
}