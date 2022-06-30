import 'package:flutter/material.dart';

import 'do_theme.dart';

class Setting extends StatefulWidget {
  const Setting({Key key}) : super(key: key);

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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PreferencePage())
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.color_lens, color: Colors.white,),
                      SizedBox(width: 15,),
                      Text("Theme", style: TextStyle(color: Colors.white),),
                    ],
                  )
              ),
              Divider(
                  color: Colors.grey
              ),
              TextButton(
                  onPressed: (){

                  },
                  child: Row(
                    children: [
                      Icon(Icons.help, color: Colors.white,),
                      SizedBox(width: 15,),
                      Text("Help", style: TextStyle(color: Colors.white),),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
