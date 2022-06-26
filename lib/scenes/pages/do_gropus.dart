import 'package:do_app/scenes/pages/do_main.dart';
import 'package:flutter/material.dart';

import '../../app.dart';

class doGropus extends StatefulWidget {
  const doGropus({Key key}) : super(key: key);

  @override
  State<doGropus> createState() => _doGropusState();
}

class _doGropusState extends State<doGropus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextField(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoApp())

                  );
                },
                child: Text("Press Key")
            )
          ],
        ),
      ),
    );
  }
}
