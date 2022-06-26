import 'package:do_app/scenes/pages/do_group.dart';
import 'package:do_app/scenes/pages/do_main.dart';
import 'package:do_app/scenes/pages/do_setting.dart';
import 'package:do_app/services/todo_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
//import 'bloc/task_bloc/task_bloc.dart';

class DoApp extends StatefulWidget {
  const DoApp({Key key}) : super(key: key);

  @override
  State<DoApp> createState() => _DoAppState();
}


class _DoAppState extends State<DoApp> with TickerProviderStateMixin{
    List<Widget> myTabs = [
    Tab(text: "All",),
  ];

    List<Widget> views = [
      MainScreenWrapper(),
    ];

   TabController tabController;

   @override
   void initState(){
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
    // BlocProvider.of<TaskBloc>(context).add(NoteInitialEvent());
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
                    bottom:  TabBar(
                      tabs: myTabs.toList(),
                      controller: tabController,
                    ),
                    title: const Text('Do App'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            var result =  myTabs.add(
                                const Tab(
                                  text: "New",
                                )
                            );
                            views.add(MainScreenWrapper());
                            print(myTabs.length);
                            return result;
                          });
                        },
                        icon: Icon(Icons.add),
                      )
                    ],
                  ),
                  body: TabBarView(
                    children: views.toList(),
                  ),
                );
              }
            ),
          ),
    );
  }
}
