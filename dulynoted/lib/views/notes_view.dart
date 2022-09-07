import 'package:flutter/material.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              print("Log out button pressed");
            }, child: const Text("Log Out"))
        ],
      ),
    );
  }
}
