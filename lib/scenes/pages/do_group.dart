import 'package:flutter/material.dart';

import '../../bloc/task_bloc/task_bloc.dart';
import '../../models/do_model.dart';

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
    
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.orange])),
        child: Scaffold(
          body: Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget> [
                  Text("Group name"),
                  SizedBox(height: 5,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter a group name.',
                    ),
                    controller: controllerTask,
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
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
                      child: Text("Add"),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
