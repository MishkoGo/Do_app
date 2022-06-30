import 'package:do_app/scenes/pages/do_group.dart';
import 'package:do_app/scenes/pages/do_main.dart';
import 'package:do_app/scenes/pages/do_setting.dart';
import 'package:do_app/services/todo_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'bloc/task_bloc/task_bloc.dart';
import 'models/do_model.dart';
//import 'bloc/task_bloc/task_bloc.dart';

class DoApp extends StatefulWidget {
  const DoApp({Key key}) : super(key: key);

  @override
  State<DoApp> createState() => _DoAppState();
}


class _DoAppState extends State<DoApp> with TickerProviderStateMixin {
  List<Tab> myTabs = [
    Tab(text: "All",),
  ];

  List<Widget> views = [
    const MainScreenWrapper(),
  ];

  TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: myTabs.length);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerTask = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      home: DefaultTabController(
        length: myTabs.length,
        child: Builder(
            builder: (context) {
              tabController = DefaultTabController.of(context);
              return Scaffold(
                appBar: AppBar(
                  bottom: TabBar(
                    tabs: myTabs.toList(),
                    controller: tabController,
                  ),
                  title: const Text('Do App'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          var result = myTabs.add(
                              const Tab(
                                text: "New",
                              )
                          );
                          views.add(Container());
                          return result;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => FirebaseAuth.instance.signOut(),
                    ),
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
                body: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoaded) {
                      return TabBarView(
                        children: views.toList(),
                      );
                    }
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery
                              .of(context)
                              .viewInsets,
                          child: Container(
                            height: 140,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
                                  child: TextField(
                                    onSubmitted: (model){
                                      var model = DoModel(
                                        task: controllerTask.text,
                                      );
                                      context.read<TaskBloc>().add(
                                          AddTaskEvent(model: model.task));
                                      controllerTask.clear();
                                      Navigator.pop(context);
                                      print("Добавил");
                                    },
                                    decoration: InputDecoration(
                                      labelText: "+add new task",
                                    ),
                                    controller: controllerTask,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  tooltip: 'Add task',
                  child: new Icon(Icons.add),
                ),
              );
            }
        ),
      ),
    );
  }
}
