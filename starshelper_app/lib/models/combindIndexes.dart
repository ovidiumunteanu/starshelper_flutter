import './index.dart';

// this class contains one data for generating of a time table
// this class is a list of CIndex which can create one timetable
class CcombinedIndexes {
  bool genPossible;
  bool isUsed;
  final List<CIndex> indexModules;

  CcombinedIndexes(this.genPossible, this.isUsed, this.indexModules);
}
