import 'package:flutter/material.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key key}) : super(key: key);

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Group"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget> [
              Text("Group name"),
              SizedBox(height: 5,),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter a group name.',
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () {},
                  child: Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
