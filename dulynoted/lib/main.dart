import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dulynoted/firebase_options.dart';
import 'package:dulynoted/views/login_view.dart';
import 'package:dulynoted/views/register_view.dart';

void main() {
  //ensures Futures are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Duly Noted',
    theme: ThemeData(
      primarySwatch: Colors.teal,
    ),
    // home: const RegisterView(),
    // home: const LoginView(),
    home: const Homepage(),
  ));
}

//Creating a stateless homepage

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),

        // using FutureBuilder so that the widget does not load until Firebase has initialized
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),

          // snapshot has status of the Future - none, waiting, active or done
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                final emailVerified = user?.emailVerified ?? false;
                // print(user);
                // print(emailVerified);
                // print(user?.emailVerified);
                if (emailVerified) {
                  return const Text("Done");
                  // return const Homepage();
                  // return const LoginView();
                  // return const RegisterView();
                } else {
                  return const VerifyEmailView(); // passing fragment instead of activity
                  // return const LoginView();
                }
              default:
                return const Text("Loading...");
            }
          },
        ));
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Please verify your email address"),
        ElevatedButton(onPressed: () async {
          final user = FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();
        }, child: const Text("Send Email Verification"))
      ],
    );
  }
}
