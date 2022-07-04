import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_app/bloc/task_bloc/task_bloc.dart';
import 'package:do_app/models/do_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class MainScreenWrapper extends StatefulWidget {

  const MainScreenWrapper({Key key,}) : super(key: key);

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
     TextEditingController controllerTask = TextEditingController();
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box<DoModel>("Note").listenable(),
        builder: (context, Box<DoModel> value, Widget _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is NoteInitial) {
                      return Container();
                    }
                    if (state is TaskLoaded) {
                      return ListTask(
                        date: date,
                        state: state,);
                    }
                    else {
                      return Text("No Work");
                    }
                  },
                ),
              ],
            ),
          );
        }
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
                    height: 130,
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
                           ElevatedButton(
                             onPressed: () {
                              CollectionReference users = FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection('Note');
                                 users
                                  .add({'Note': controllerTask.text})
                                  .then((value) => print("User Document"))
                                  .catchError((error) => print("Failed to add user: $error"));
                               },
                             child: Text("add Firebase")),
                        // TextButton(
                        //   onPressed: () async{
                        //     DateTime newDate = await showDatePicker(
                        //       context: context,
                        //       initialDate: date,
                        //       firstDate: DateTime(1900),
                        //       lastDate: DateTime(2100),
                        //     );
                        //     setState(() => date = newDate);
                        //   },
                        //   child: const Icon(
                        //     Icons.calendar_today, color: Colors.white,),
                        // ),
                        Text(
                            '${date.year}/${date.month}/${date.day}',
                        )
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
}

class ListTask extends StatefulWidget {

  final TaskLoaded state;
  final DoModel model;
  final DateTime date;
  final int index;

  ListTask({
    Key key,
     this.date,
    this.state, this.index, this.model,
  }) : super(key: key);


  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  TextEditingController controllerTask = TextEditingController();
  bool isState = false;
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: Hive.box<DoModel>("Note").listenable(),
      builder: (context, Box<DoModel> value, Widget _) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: widget.state.todos.length,
          itemBuilder: (BuildContext context, int index) {
            DoModel todo = value.getAt(index);
            final note = widget.state.todos[index];
            controllerTask.value.text;
            return Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (value) {
                      BlocProvider.of<TaskBloc>(context).add(
                          DeleteTaskEven(model: index));
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (value) {
                      controllerTask.text = todo.task;
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
                                      decoration: InputDecoration(
                                        labelText: todo.task,
                                      ),
                                      controller: controllerTask,
                                      onSubmitted: (value) {
                                        var model = DoModel(
                                            task: controllerTask.value.text
                                        );
                                        context.read<TaskBloc>().add(
                                            AddTaskEvent(model: model.task));
                                        context.read<TaskBloc>().add(
                                            DeleteTaskEven(model: index));
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    backgroundColor: Colors.yellow,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (value) {
                      print(controllerTask.value.text);
                      Fluttertoast.showToast(msg: 'Copied');
                    },
                    backgroundColor: Colors.grey,
                    icon: Icons.copy,
                    label: 'Copy',
                  ),
                ],
              ),
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                dismissible: DismissiblePane(onDismissed: () {},),
                children: [
                  SlidableAction(
                    onPressed: (value) {
                      Text(note.task, style: TextStyle(color: Colors.green),);
                    },
                      backgroundColor: Colors.green,
                      icon: Icons.check_box,
                  )
                ],
              ),
              child: ListTile(
                title: Text(note.task),
                onTap: () {
                },
                // leading: const CircleAvatar(
                //   radius: 10,
                //   //backgroundColor: colorNum == 2 ? Colors.red : Colors.black12,
                // )
                //title: Text('${res?.task}'),
                // subtitle: Text(
                //   '${date.year}/${date.month}/${date.day}',),
              )
            );
          }
        );
       }
    );
  }
}

