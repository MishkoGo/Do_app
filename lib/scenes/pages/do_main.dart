import 'package:do_app/bloc/task_bloc/task_bloc.dart';
import 'package:do_app/main.dart';
import 'package:do_app/models/do_model.dart';
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
                                task: controllerTask.value.text,
                              );
                              context.read<TaskBloc>().add(
                                  AddTaskEvent(model: model.task));
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

class NewWidget extends StatelessWidget {
  final TaskLoaded state;
  NewWidget({
    Key key,
     this.date,
    this.state, this.index,
  }) : super(key: key);

  final _controllerTask = TextEditingController();
  final DateTime date;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.todos.length,
          itemBuilder: (BuildContext context, int index) {
            final DoModel note = state.todos[index];
            return Slidable(
              key: UniqueKey(),
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (value) {
                      BlocProvider.of<TaskBloc>(context).add(DeleteTaskEven(model: index));
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (value) {
                      showDialog(
                          context: context,
                          builder: (ctx) =>
                              AlertDialog(
                                title: Text("Edit"),
                                content: TextField(
                                  onSubmitted: (model) {
                                    BlocProvider.of<TaskBloc>(context).add(
                                      UpdateTaskEven(
                                          title: _controllerTask.text,
                                          index: index,
                                      ),
                                    );
                                    print("Edit");
                                    Navigator.pop(context);
                                  },
                                  controller: _controllerTask,
                                ),
                              )
                      );
                    },
                    backgroundColor: Colors.yellow,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (value) {
                      print(_controllerTask.value.text);
                      Fluttertoast.showToast(msg: 'Copied');
                    },
                    backgroundColor: Colors.grey,
                    icon: Icons.copy,
                    label: 'Copy',
                  ),
                ],
              ),
              child: ListTile(
                title: Text('${note.task}'),
                //title: Text('${res?.task}'),
                // subtitle: Text(
                //   '${date.year}/${date.month}/${date.day}',),
              ),
            );
          }
      ),
    );
  }
}

