import 'package:do_app/models/do_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'app.dart';
import 'models/do_model.g.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(DoModelAdapter());
  await Hive.openBox<DoModel>(HiveBoxes.todo);
  runApp(const DoApp());
}
class HiveBoxes {
  static String todo = 'todo_box';
}