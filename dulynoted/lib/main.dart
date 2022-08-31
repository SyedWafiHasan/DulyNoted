import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    title: 'Duly Noted',
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: const MyHomePage(),
  ));
}

//Creating a stateless homepage
class MyHomePage extends StatelessWidget
{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register User"),
      ),
    );
  }
}

