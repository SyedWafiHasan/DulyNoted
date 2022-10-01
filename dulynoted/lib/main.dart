import 'package:flutter/material.dart';
import 'package:dulynoted/views/notes/notes_view.dart';
import 'package:dulynoted/views/login_view.dart';
import 'package:dulynoted/views/register_view.dart';
import 'package:dulynoted/views/verify_email_view.dart';
import 'package:dulynoted/views/home_page.dart';
import 'package:dulynoted/constants/routes.dart';
import 'package:dulynoted/views/notes/new_note_view.dart';

void main() {
  //ensures Futures are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Duly Noted',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // home: const RegisterView(),
      // home: const LoginView(),
      home: const Homepage(),
      routes: { // routes are also like Intents
        loginRoute : (context) => const LoginView(),
        registerRoute : (context) => const RegisterView(),
        verifyRoute : (context) => const VerifyEmailView(),
        notesRoute : (context) => const NotesView(),
        newNotesRoute : (context) => const NewNoteView(),
      },
    )
  );
}


