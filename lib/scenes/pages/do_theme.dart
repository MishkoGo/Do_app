import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme_bloc/theme_bloc.dart';
import '../../core/repositories/app_theme.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({Key key}) : super(key: key);

  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

bool _iconbool = false;

ThemeData _light = ThemeData(
  //primarySwatch: Colors.amber,
  brightness: Brightness.light,
);

ThemeData _dark = ThemeData(
  //primarySwatch: Colors.black12,
  brightness: Brightness.dark,
);

class _PreferencePageState extends State<PreferencePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _iconbool ? _dark : _light,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Preferences'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _iconbool = !_iconbool;
                  });
                },
                icon: Icon(Icons.color_lens))
          ],
        ),
      ),
    );
  }
}