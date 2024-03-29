import 'package:flutter/material.dart';
import 'package:dulynoted/constants/routes.dart';
import 'package:dulynoted/services/auth/auth_exceptions.dart';
import 'package:dulynoted/services/auth/auth_service.dart';
import 'package:dulynoted/utilities/error_dialog.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
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

              try // try block to handle exception if user does not exist
              {
                // if a Future is returned, you need to use await to get the result
                // await FirebaseAuth.instance.signInWithEmailAndPassword(
                //   email: email,
                //   password: password
                // );

                await AuthService.firebase().logIn(
                  email: email,
                  password: password
                );

                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                  await showErrorDialog(context, "User Not Found");
              } on WrongPasswordAuthException {
                  await showErrorDialog(context, "Wrong Password");
              } on GenericAuthException {
                  await showErrorDialog(context, "Authentication error");
              }
            },
            child: const Text("Login"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text("Register a new user"))
        ],
      ),
    );
  }
}
