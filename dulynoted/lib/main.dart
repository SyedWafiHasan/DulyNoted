import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    title: 'Duly Noted',
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    home: const MyHomePage(),
  ));
}

//Creating a stateless homepage
class MyHomePage extends StatefulWidget
{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState()
  {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose()
  {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register User"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(
              hintText: "Password",
            ),
          ),
          TextButton(
            onPressed: () async
            {
              print("Button pressed");
            },
            child: const Text("Ye hai ek button"),
            ),
          ],
        )
    );
  }
}

