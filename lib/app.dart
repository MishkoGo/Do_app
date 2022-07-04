import 'package:do_app/core/repositories/app_theme.dart';
import 'package:do_app/scenes/pages/do_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ThemeManager _themeManager = ThemeManager();

class DoApp extends StatefulWidget {
  const DoApp({Key key}) : super(key: key);

  @override
  State<DoApp> createState() => _DoAppState();
}

class _DoAppState extends State<DoApp>{

  @override
  void dispose(){
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener(){
    if(mounted) {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: Scaffold(
              appBar: AppBar(
                title: const Text('Do App'),
              ),
              body: MainScreenWrapper(),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(48, 48, 48, 100)
                      ),
                      child: Text('Drawer Header'),
                    ),
                    ListTile(
                      title: const Text('About'),
                      onTap: () {
                      },
                    ),
                    ListTile(
                      title: const Text('Exit'),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Row(
                            children: [
                              Text(_themeManager.themeMode == ThemeMode.dark ? 'Dark Mode' : 'Light Mode'),
                            ],
                          ),
                          Switch(
                            value: _themeManager.themeMode == ThemeMode.dark,
                            onChanged: (newValue) {
                              _themeManager.toggleTheme(newValue);
                            },
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
         )
    );
  }
}
