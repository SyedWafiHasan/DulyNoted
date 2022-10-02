import 'package:dulynoted/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:dulynoted/views/login_view.dart';
import 'package:dulynoted/views/notes_view.dart';
import 'package:dulynoted/views/verify_email_view.dart';

//Creating a stateless homepage

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        // snapshot has status of the Future - none, waiting, active or done
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
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
