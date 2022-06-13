import 'package:do_app/scenes/pages/do_main.dart';
import 'package:do_app/scenes/pages/do_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/task_bloc/task_bloc.dart';
import 'models/do_model.dart';

class DoApp extends StatefulWidget {
  const DoApp({Key? key}) : super(key: key);

  @override
  State<DoApp> createState() => _DoAppState();
}

class _DoAppState extends State<DoApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TaskBloc()
                ..add(
                  const LoadTask(todos: [
                    DoModel(
                        task: 'fgf'
                    ),
                  ]),
                )
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
        ),
        home: Scaffold(
          body: MainScreenWrapper(),
        ),
      ),
    );
  }
}
