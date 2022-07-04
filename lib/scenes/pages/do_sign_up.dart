
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_app/scenes/pages/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpWidget({Key key, @required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose()
  {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(25),
    child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
              alignment: Alignment.topLeft,
              child: Text("Email", style: TextStyle(fontSize: 16),)
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
              email != null && !EmailValidator.validate(email)
                  ? 'Enter a valid email' : null
          ),
          SizedBox(height: 30,),
          Container(
              alignment: Alignment.topLeft,
              child: Text("Password", style: TextStyle(fontSize: 16),)
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) =>
            value != null && value.length < 6
                ? 'Enter min 6 characters'
                :  null,
          ),
          SizedBox(height: 40,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              minimumSize: Size.fromHeight(50),
            ),
            child: Text("Sign Up", style: TextStyle(fontSize: 17),),
            onPressed: signUp,
           // onPressed: signUp,
          ),
          SizedBox(height: 24,),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.white),
                  text: 'Already have an account?',
                  children: [
                    TextSpan(
                        text:  " | ",
                        style: TextStyle(
                          wordSpacing: 10,
                        )
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        text: 'Log In',
                        style: TextStyle(
                          color: Colors.blue,
                        )
                    )
                  ]
              )
          )
        ],
      ),
    ),
  );
  Future signUp() async {

    final isValid = formKey.currentState.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      users
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({'Email': emailController.text})
        .then((value) => print("User Document Added"))
        .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

  }
}
