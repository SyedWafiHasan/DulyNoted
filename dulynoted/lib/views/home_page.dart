import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dulynoted/firebase_options.dart';
import 'package:dulynoted/views/login_view.dart';
import 'package:dulynoted/views/notes_view.dart';
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
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const NotesView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
      }
    );
  }
}
