import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yatra/core/constants/app_string.dart';
import 'package:yatra/features/test/logout_page.dart';
import 'package:yatra/features/widgets/custom_button.dart';

class GoogleLoginPage extends StatefulWidget {
  const GoogleLoginPage({super.key});

  @override
  State<GoogleLoginPage> createState() => _GoogleLoginPageState();
}

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    User? user = userCredential.user;
    String token = "";
    await user?.getIdToken().then((value) {
      token = value!;
    });
    print("token is " + token);

    if (user != null) {
      print("Email: ${user.email}");
      print("Name: ${user.displayName}");
      print("Photo: ${user.photoURL}");
      print("UID: ${user.uid}");
      print("Phone number (if available): ${user.phoneNumber}");

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LogoutPage(name: user.displayName,email: user.email,imagePath: user.photoURL,)),
        (Route<dynamic> route) => false,
      );
    }
  } on Exception catch (e) {
    print('exception->$e');
  }
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50),
            CustomButton(
              onPressed: () async {
                await signInWithGoogle(context);
              },
              child: Row(
                children: [
                  Image.asset("assets/images/google.png"),
                  SizedBox(width: 10),
                  Text(googleLogin),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

