import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime date = DateTime.now();
  List<String> todo = [];


  void incrementCounter(String val) {
      setState(() {
          todo.add(val);
      });
  }

  Widget _buildToDo() {
    return new ListView.builder(
        itemCount: todo.length,
        itemBuilder: (context, index) {
          return _buildTodoItem(todo[index]);
        }
    );
  }

  Widget _buildTodoItem(String todoText){
    return new ListTile(
      title: new Text(todoText),
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
                    MaterialPageRoute(builder: (context) => SeconRate())
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

                  ElevatedButton(
                    onPressed: (){
                      showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                      );
                      setState(() => date);
                    }, child: null,
                  )
                ],
              ),
            ),
          );
        }
    );
  }

}

class SeconRate extends StatefulWidget {
  const SeconRate({Key? key}) : super(key: key);

  @override
  State<SeconRate> createState() => _SeconRateState();
}

class _SeconRateState extends State<SeconRate> {
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
