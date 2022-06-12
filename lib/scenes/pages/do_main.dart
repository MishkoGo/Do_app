import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({Key? key}) : super(key: key);

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {

  DateTime date = DateTime.now();
  List<String> todo = [];

  void incrementCounter(String val) {
    setState(() {
      todo.add(val);
    });
  }

  Widget _buildToDo() {
    return ListView.builder(
        itemCount: todo.length,
        itemBuilder: (context, index) {
          return Slidable(
              key: const ValueKey(0),
              endActionPane: ActionPane(
                dismissible: DismissiblePane(onDismissed: () {

                }),
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                      onPressed: (value) {
                        todo.removeAt(index);
                        setState((){});
                      },
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    label: 'Delete',
                  )
                ],
              ),
              child: _buildTodoItem(todo[index]));
        }
    );
  }

  Widget _buildTodoItem(String todoText){
    return new ListTile(
      title: new Text(todoText),
    );
  }

  void _pushAddTodoScreen() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (BuildContext context){
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 150,
              child: Column(
                children: <Widget> [
                  TextField(
                      onSubmitted: (val){
                        incrementCounter(val);
                        _buildToDo();
                        Navigator.pop(context);
                      }
                  ),

                  TextButton(
                    onPressed: (){
                      showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      setState(() => date);
                    },
                    child: const Icon(Icons.calendar_today, color: Colors.black,),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Do App"),
        actions: [
          IconButton(
            onPressed: (){
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
      body: _buildToDo(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(Icons.add)
      ),
      //
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
