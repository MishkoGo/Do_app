import 'package:do_app/models/do_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task_bloc/task_bloc.dart';
import '../../services/todo_database.dart';
import 'do_main.dart';

class TaskProvider extends StatelessWidget {
  const TaskProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(TodoDatabase())
        ),
      ],
      child: MainScreenWrapper(),
    );
  }
}
