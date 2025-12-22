import 'package:flutter/material.dart';
import 'package:yatra/core/constants/app_color.dart';
import 'package:yatra/core/constants/app_string.dart';
import 'package:yatra/features/auth/pages/signup_page.dart';
import 'package:yatra/features/widgets/custom_button.dart';
import 'package:yatra/features/widgets/custom_textform.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;
  bool obscurePassword = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(onTap: () {}, child: Icon(Icons.arrow_back_ios)),
                  SizedBox(height: 15),
                  Text(
                    welcomeLabel,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(loginSubtitleLabel, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 40),
                  // Illustration Placeholder
                  Center(
                    child: SizedBox(
                      height: 250,
                      child: Image.asset(
                        "assets/images/illustration_login.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Text(
                    emailLabel,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 3),
                  CustomTextformfield(
                    borderRadius: 8,
                    onChanged: (value) {
                      email = value;
                    },
                    hintText: emailHint,
                    labelStyle: TextStyle(color: Colors.grey),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return errorInvalidEmail;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    passwordLabel,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 3),
                  CustomTextformfield(
                    borderRadius: 8,
                    maxLines: 1,
                    obscureText: obscurePassword ? true : false,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return errorInvalidPassword;
                      }
                      return null;
                    },
                    hintText: passswordHint,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => obscurePassword = !obscurePassword);
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          forgotPasswordLabel,
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() => rememberMe = value!);
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(rememberLabel),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      backgroundColor: primaryColor,
                      borderRadius: 8,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        signinLabel,
                        style: TextStyle(fontSize: 16, color: secondaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dontHaveAccountLabel,
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                           Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                        },
                        child: Text(
                          signupLabel,
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
