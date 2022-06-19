import 'package:do_app/scenes/pages/do_group.dart';
import 'package:do_app/scenes/pages/do_main.dart';
import 'package:do_app/scenes/pages/do_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'bloc/task_bloc/task_bloc.dart';

class DoApp extends StatefulWidget {
  const DoApp({Key? key}) : super(key: key);

  @override
  State<DoApp> createState() => _DoAppState();
}

class _DoAppState extends State<DoApp> {
  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

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
        home: Builder(
          builder: (context) {
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  bottom:  TabBar(
                    isScrollable: true,
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
                        Tab(
                          child: IconButton(
                            splashRadius: 10,
                            iconSize: 22,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NewGroup())
                              );
                            },
                            icon: Icon(Icons.add),
                          ),
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
                    Text("Failed 2"),
                  ],
                )
              ),
            );
          }
        ),
      ),
    );
  }
}
