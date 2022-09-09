import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dulynoted/firebase_options.dart';
import 'package:dulynoted/views/login_view.dart';
import 'package:dulynoted/views/register_view.dart';
import 'package:dulynoted/views/verify_email_view.dart';
import 'package:dulynoted/views/home_page.dart';

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
    routes: { // routes are also like Intents
      '/login/' : (context) => const LoginView(),
      '/register/' : (context) => const RegisterView(),
      '/verify/' : (context) => const VerifyEmailView()
    },
  ));
}


