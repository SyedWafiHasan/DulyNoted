import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _email,
          autocorrect: false,
          enableSuggestions: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "Email",
          ),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          decoration: const InputDecoration(
            hintText: "Password",
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;

            try // try block to handle exception if user does not exist
            {
              // if a Future is returned, you need to use await to get the result
              final userAuth = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print("User Not Found");
              } else if (e.code == 'wrong-password') {
                print("Password Incorrect");
              } else if (e.code == 'user-disabled') {
                print("Sorry, this user has been disabled.");
              } else {
                print("Something else happened : ${e.code}");
              }
            }
          },
          child: const Text("Login"),
        ),
        ElevatedButton(
          onPressed: () {
            print("Button daba diye? Nahi dabana tha");
          },
          child: Text("Go to other page"))
      ],
    );
  }
}
