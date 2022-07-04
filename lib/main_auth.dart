import 'package:do_app/scenes/pages/do_sign_in.dart';
import 'package:do_app/scenes/pages/utils.dart';
import 'package:do_app/services/todo_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_reg.dart';
import 'app.dart';
import 'bloc/task_bloc/task_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      home: MainPageHome(),
    );
  }
}
class MainPageHome extends StatelessWidget {
  const MainPageHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong!'),
            );
          }
          else if (snapshot.hasData) {
            return BlocProvider(
                create: (context) =>
                TaskBloc(TodoDatabase())
                  ..add(NoteInitialEvent()),
                child: DoApp()
            );
          }
          else {
            return AuthPage();
          }
        }
      );
  }
}
