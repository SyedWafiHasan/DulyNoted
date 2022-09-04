import 'package:dulynoted/views/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  //ensures Futures are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Duly Noted',
    theme: ThemeData(
      primarySwatch: Colors.teal,
    ),
    // home: const RegisterView(),
    home: const LoginView(),
  ));
}
//Creating a stateless homepage, but converted to Stateful later
