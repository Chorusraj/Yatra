import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yatra/features/test/google_login_page.dart';
import 'package:yatra/features/widgets/custom_button.dart';

class LogoutPage extends StatelessWidget {
  String? imagePath, name, email;
  LogoutPage({super.key, this.email, this.imagePath, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.network(imagePath ?? ""),
            Text("name is ${name ?? ""}"),
            Text("email is ${email ?? ""}"),

            CustomButton(
              onPressed: () async {
                await signOutFromGoogle(context);
              },
              child: Text("logout"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> signOutFromGoogle(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => GoogleLoginPage()),
      (Route<dynamic> route) => false,
    );
  } on Exception catch (_) {}
}
