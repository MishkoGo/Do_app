import 'package:flutter/material.dart';

import '../../bloc/task_bloc/task_bloc.dart';
import '../../models/do_model.dart';

class ShowDo extends StatefulWidget {
  final TaskLoaded state;
  final DoModel model;
  final DateTime date;
  final int index;
  const ShowDo({Key key, this.state, this.model, this.date, this.index}) : super(key: key);


  @override
  State<ShowDo> createState() => _ShowDoState();
}

class _ShowDoState extends State<ShowDo> {
  @override
  Widget build(BuildContext context) {

    String title = widget.model != null ? widget.model.task : "";
    final controllerTask = TextEditingController(text: title);

    return Container(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // TextField(
              //   controller: controllerTask,
              // ),
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
      ),
    );
  }
}
