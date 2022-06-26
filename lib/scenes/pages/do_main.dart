import 'package:do_app/bloc/task_bloc/task_bloc.dart';
import 'package:do_app/main.dart';
import 'package:do_app/models/do_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'do_show.dart';


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
      resizeToAvoidBottomInset: true,
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
                      return NewWidget(
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
                        TextButton(
                          onPressed: () async{
                            DateTime newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            setState(() => date = newDate);
                          },
                          child: const Icon(
                            Icons.calendar_today, color: Colors.white,),
                        ),
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
    //
  }
}

class NewWidget extends StatefulWidget {
  final TaskLoaded state;
  final DoModel model;
  NewWidget({
    Key key,
     this.date,
    this.state, this.index, this.model,
  }) : super(key: key);

  final DateTime date;
  final int index;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  TextEditingController controllerTask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title = widget.model != null ? widget.model.task : "";
    //TextEditingController controllerTask = new TextEditingController();

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
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: (){
                                        var model = DoModel(
                                          task: controllerTask.value.text
                                        );
                                        context.read<TaskBloc>().add(
                                            AddTaskEvent(model: model.task));
                                        context.read<TaskBloc>().add(
                                            DeleteTaskEven(model: index));
                                        Navigator.pop(context);
                                      },
                                      child: Text("Add")
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      // showDialog(
                      //         context: context,
                      //         builder: (ctx) =>
                      //             AlertDialog(
                      //               title: Text(note.task),
                      //               content: TextField(
                      //                 onTap: (){
                      //                   print(note.task);
                      //                 },
                      //                 onSubmitted: (f){
                      //                   BlocProvider.of<TaskBloc>(context).add(
                      //                                 UpdateTaskEven(
                      //                                   title: note.task,
                      //                                 ),
                      //                               );
                      //                   Navigator.pop(context);
                      //                 },
                      //                 controller: controllerTask,
                      //               ),
                      //               // content: Column(
                      //               //
                      //               //   children: [
                      //               //
                      //               //     TextField(
                      //               //       // onTap: (){
                      //               //       //   BlocProvider.of<TaskBloc>(context).add(
                      //               //       //     UpdateTaskEven(
                      //               //       //       title: todo.task,
                      //               //       //     ),
                      //               //       //   );
                      //               //       // },
                      //               //       onSubmitted: (a) {
                      //               //         print("Edit");
                      //               //         Navigator.pop(context);
                      //               //       },
                      //               //       controller: controllerTask,
                      //               //     ),
                      //               //   ],
                      //               // ),
                      //             )
                      //     );

                      // showDialog(
                      //     context: context,
                      //     builder: (ctx) =>
                      //         AlertDialog(
                      //           title: Text("Edit"),
                      //           content: Column(
                      //             children: [
                      //               TextField(
                      //                 controller: controllerTask,
                      //               ),
                      //               TextField(
                      //                 onSubmitted: (a) {
                      //                   BlocProvider.of<TaskBloc>(context).add(
                      //                     UpdateTaskEven(
                      //                         title: controllerTask.text,
                      //                         index: widget.index,
                      //                     ),
                      //                   );
                      //                   print("Edit");
                      //                   Navigator.pop(context);
                      //                 },
                      //                 controller: controllerTask,
                      //               ),
                      //             ],
                      //           ),
                      //         )
                      // );
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
              child: ListTile(
                title: Text(note.task),
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

class NewGroup extends StatefulWidget {
  final TaskLoaded state;
  final DoModel model;
  final DateTime date;
  final int index;
  const NewGroup({Key key, this.state, this.model, this.date, this.index}) : super(key: key);

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {

  @override
  Widget build(BuildContext context) {

    String title = widget.model != null ? widget.model.task : "";
    final controllerTask = TextEditingController(text: title);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget> [
            TextField(
              controller: controllerTask,
            ),
            SizedBox(height: 10,),
            // ElevatedButton(
            //   onPressed: () {
            //     showModalBottomSheet(
            //       context: context,
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            //       builder: (BuildContext context) {
            //         return Padding(
            //           padding: MediaQuery
            //               .of(context)
            //               .viewInsets,
            //           child: Container(
            //             height: 140,
            //             child: Column(
            //               children: <Widget>[
            //                 Padding(
            //                   padding: const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
            //                   child: TextField(
            //                     controller: controllerTask,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         );
            //       },
            //     );
            //   },
            //   child: Text("Add"),
            // )
          ],
        ),
      ),
    );
  }
}


