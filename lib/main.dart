
import 'package:do_app/bloc/task_bloc/task_bloc.dart';
import 'package:do_app/models/do_model.dart';
import 'package:do_app/services/todo_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'main_auth.dart';
import 'models/do_model.g.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter<DoModel>(DoModelAdapter());
  await Hive.openBox<DoModel>("Note");

  runApp(const MainPage());
}