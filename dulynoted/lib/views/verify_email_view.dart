import 'package:flutter/material.dart';
import 'package:dulynoted/services/auth/auth_service.dart';
import 'package:dulynoted/constants/routes.dart';
import 'package:dulynoted/utilities/log_out_dialog.dart';
import 'package:dulynoted/enums/menu_action.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false
                    );
                  }
                break;
              }
            }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("Log out"),
              ),
            ];
          },
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("We've sent you an email verification. Please verify yourself to move forward."),
          const Text("The email might also be in your spam folder. Please make sure you check that."),
          const Text("If you still haven't received an email, press the button below."),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text("Send Email Verification")
          ),
          ElevatedButton(
            onPressed:  () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("Restart")
          )
        ],
      ),
    );
  }
}