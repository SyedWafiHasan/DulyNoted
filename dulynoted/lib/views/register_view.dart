import 'package:dulynoted/constants/routes.dart';
import 'package:dulynoted/services/auth/auth_service.dart';
import 'package:dulynoted/services/auth/auth_exceptions.dart';
import 'package:dulynoted/utilities/error_dialog.dart';
import 'package:flutter/material.dart';

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
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyRoute);

              } on WeakPasswordAuthException {
                  await showErrorDialog(context, "Weak Password");
              } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(context, "Email already in use");
              } on InvalidEmailAuthException {
                  await showErrorDialog(context, "Invalid email address entered");
              } on GenericAuthException {
                  await showErrorDialog(context, "Failed to register");
              }
              catch (e) {

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
