import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dulynoted/firebase_options.dart';
import 'package:dulynoted/views/login_view.dart';
import 'package:dulynoted/views/register_view.dart';
import 'package:dulynoted/views/verify_email_view.dart';

//Creating a stateless homepage

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),

      // snapshot has status of the Future - none, waiting, active or done
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
        // return const LoginView();
        final user = FirebaseAuth.instance.currentUser;
        final emailVerified = user?.emailVerified ?? false;
        print(user);
        print(emailVerified);
        print(user?.emailVerified);
        if (emailVerified) {
          return const Text("Done");
        return const Homepage();
        return const LoginView();
        return const RegisterView();
        } else {
          return const VerifyEmailView(); // passing fragment instead of activity
        }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}