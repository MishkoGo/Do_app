import 'package:do_app/scenes/pages/do_main.dart';
import 'package:flutter/material.dart';

class DoApp extends StatefulWidget {
  const DoApp({Key? key}) : super(key: key);

  @override
  State<DoApp> createState() => _DoAppState();
}

class _DoAppState extends State<DoApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MainScreenWrapper(),
      ),
    );
  }
}
