import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main()
{
  //ensures Futures are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Duly Noted',
    theme: ThemeData(
      primarySwatch: Colors.teal,
    ),
    home: const RegisterView(),
  ));
}

// creating Stateful RegisterView widget
// this will be used as the base of our register view
class RegisterView extends StatefulWidget
{
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
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

        // using FutureBuilder so that the widget does not load until Firebase has initialized
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),

          // snapshot has status of the Future - none, waiting, active or done
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;

                        // if a Future is returned, you need to use await to get the result
                        final userAuth = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: email, password: password);

                        print(userAuth);
                      },
                      child: const Text("Register"),
                    ),
                  ],
                );
              default:
                return const Text("Loading...");
            }
          },
        )
    );
  }
}


//Creating a stateless homepage, but converted to Stateful later


