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
    return BlocProvider(
      create: (context) => TaskBloc()..add(LoadTask()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: "All",
                    ),
                    Tab(
                      text: "Today",
                    ),
                    Tab(
                      text: 'Default Group',
                    ),
                  ],
              ),
              title: const Text('Do App'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Setting())
                    );
                  },
                  icon: Icon(Icons.settings),
                )
              ],
            ),
            body: const TabBarView(
              children: [
                MainScreenWrapper(),
                Text("Failed"),
                Text("Failed 2"),
              ],
            )
          ),
        ),
      ),
    );
  }
}
