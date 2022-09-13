import 'package:dulynoted/constants/routes.dart';
import 'package:dulynoted/utilities/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:dulynoted/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import 'dart:developer' show log;

// creating Stateful RegisterView widget
// this will be used as the base of our register view
class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
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

              // if a Future is returned, you need to use await to get the result
              try {
                final userAuth = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                    email: email,
                    password: password);
                log(userAuth.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == "email-already-in-use") {
                  await showErrorDialog(context, "User already exists.");
                } else if (e.code == "weak-password") {
                  await showErrorDialog(context, "Your password is too weak.");
                } else if (e.code == "invalid-email") {
                  await showErrorDialog(context, "Invalid Email ID.");
                } else {
                  await showErrorDialog(context, "Error : ${e.code}");
                }
              } catch (e) {
                  await showErrorDialog(context, "Error : ${e.toString()}");
              }
            },
            child: const Text("Register"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("Log in existing user"))
        ],
      ),
    );
  }
}
