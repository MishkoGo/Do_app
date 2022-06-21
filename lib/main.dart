
import 'package:do_app/bloc/task_bloc/task_bloc.dart';
import 'package:do_app/models/do_model.dart';
import 'package:do_app/services/todo_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'app.dart';
import 'models/do_model.g.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter<DoModel>(DoModelAdapter());
  await Hive.openBox<DoModel>("Note");

  runApp(BlocProvider(
      create: (context) => TaskBloc(TodoDatabase()),
      child: DoApp(),
  ));
}
class HiveBoxes {
  static String todo = 'todo_box';
}