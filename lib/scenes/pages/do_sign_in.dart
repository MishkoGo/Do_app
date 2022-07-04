import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;


  const LoginWidget({Key key, @required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
              textInputAction: TextInputAction.next,
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
                child: Text("Sign In", style: TextStyle(fontSize: 17),),
                onPressed: signIn,
             ),
            SizedBox(height: 24,),
            RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.white),
                  text: 'No account?',
                  children: [
                    TextSpan(
                      text:  " | ",
                      style: TextStyle(
                        wordSpacing: 10,
                      )
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Sign Up',
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
    Future signIn() async {
      final isValid = formKey.currentState.validate();
      if (!isValid) return;

      try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
    } on FirebaseAuthException catch (e) {
        print(e);
      }

    }
}
