import 'package:do_app/bloc/task_bloc/task_bloc.dart';
import 'package:do_app/models/do_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MainScreenWrapper extends StatefulWidget {

  const MainScreenWrapper({Key? key,}) : super(key: key);

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerTask = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Do App"),
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
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if(state is TaskLoading) {
            return const CircularProgressIndicator();
          }
          if(state is TaskLoaded) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.todos.length,
                itemBuilder: (BuildContext context, int index) {
                 // return ListTile(
                 //      title: _todoCard(state.todos[index]),
                 //      onTap: () {
                 //        print("object");
                 //        var model = DoModel(task: controllerTask.value.text);
                 //        context.read<TaskBloc>().add(
                 //            DeleteTaskEven(model: model)
                 //        );
                 //        state.todos.removeAt(index);
                 //      }
                 //  );
                  return Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (value) {
                            var model = DoModel(task: controllerTask.value.text);
                            context.read<TaskBloc>().add(
                                DeleteTaskEven(model: model)
                            );
                            state.todos.removeAt(index);
                          },
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      ],
                    ),
                    child: ListTile(
                        title: _todoCard(state.todos[index]),
                    ),
                  );
                }
            );
          }
          else {
            return Text("No Work");
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
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: controllerTask,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              var model = DoModel(
                                task: controllerTask.value.text,
                              );
                              context.read<TaskBloc>().add(
                                  AddTaskEvent(model: model));
                              Navigator.pop(context);
                            },
                            child: const Text('Add To Do')
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     showDatePicker(
                        //       context: context,
                        //       initialDate: date,
                        //       firstDate: DateTime(1900),
                        //       lastDate: DateTime(2100),
                        //     );
                        //     setState(() => date);
                        //   },
                        //   child: const Icon(
                        //     Icons.calendar_today, color: Colors.black,),
                        // )
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

  Widget _todoCard(DoModel model) {
    return Row(
      children: [
        Text(
          '${model.task}',
        ),
      ],
    );
  }
}

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("in-App"),
          ],
        ),
      ),
    );
  }
}
