import 'package:hive/hive.dart';

import '../models/do_model.dart';
import '../models/do_model.g.dart';

class TodoDatabase {
  String _boxName = "Note";
  // open a box
  Future<Box> noteBox() async {
    var box = await Hive.openBox<DoModel>(_boxName);
    return box;
  }
  // get full note
  Future<List> getFullNote() async {
    final box = await noteBox();
    var box_1 =  box.values.toList();
    return box_1;
  }
  // to add data in box
  Future<void> addToBox(DoModel note) async {
    final box = await noteBox();
    await box.add(note);
  }
  // delete data from box
  Future<void> deleteFromBox(int index) async {
    final box = await noteBox();
    await box.deleteAt(index);
  }
  // update data
  Future<void> updateNote(int index, DoModel note) async {
    final box = await noteBox();
    await box.putAt(index, note);
  }
}
