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

  const MainScreenWrapper({Key? key,}) : super(key: key);

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  DateTime date = DateTime.now();

  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     TextEditingController controllerTask = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ValueListenableBuilder(
        valueListenable: Hive.box<DoModel>(HiveBoxes.todo).listenable(),
        builder: (context, Box<DoModel> box, _) {
          return BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return const CircularProgressIndicator();
              }
              if (state is TaskLoaded) {
                if(box.values.isEmpty){
                  return Center(
                    child: Text("Todo list is empty"),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: box.values.length,
                    itemBuilder: (BuildContext context, int index) {
                      late DoModel? res = box.getAt(index);
                      return Slidable(
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (value) {
                                var model = DoModel(
                                    task: controllerTask.value.text);
                                context.read<TaskBloc>().add(
                                    DeleteTaskEven(model: model)
                                );
                                state.todos.removeAt(index);
                                res?.delete();
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
                                              var model = DoModel(
                                                  task: controllerTask.value
                                                      .text
                                              );
                                              context.read<TaskBloc>().add(
                                                  UpdateTaskEven(
                                                      model: model.copyWith()));
                                              state.todos.removeAt(index);
                                              Navigator.pop(context);
                                            },
                                            controller: controllerTask,
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
                          //title: _todoCard(state.todos[index]),
                          title: Text('${res?.task}'),
                          subtitle: Text(
                            '${date.year}/${date.month}/${date.day}',),
                        ),
                      );
                    }
                );
              }
              else {
                return Text("No Work");
              }
            },
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
                        TextField(
                          onSubmitted: (model){
                            var model = DoModel(
                              task: controllerTask.value.text,
                            );
                            context.read<TaskBloc>().add(
                                AddTaskEvent(model: model));
                            Navigator.pop(context);
                            Box<DoModel> contactsBox = Hive.box<DoModel>(HiveBoxes.todo);
                            contactsBox.add(DoModel(task: controllerTask.value.text));
                          },
                          controller: controllerTask,
                        ),
                        TextButton(
                          onPressed: () async{
                            DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            setState(() => date = newDate!);
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

