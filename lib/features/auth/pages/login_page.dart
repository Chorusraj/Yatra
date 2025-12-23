import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yatra/core/constants/app_color.dart';
import 'package:yatra/core/constants/app_string.dart';
import 'package:yatra/core/utils/helper.dart';
import 'package:yatra/core/utils/route_generator.dart';
import 'package:yatra/core/utils/routes.dart';
import 'package:yatra/features/auth/bloc/auth_bloc.dart';
import 'package:yatra/features/auth/bloc/auth_event.dart';
import 'package:yatra/features/auth/bloc/auth_state.dart';
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
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              displaySnackBar(context, state.message);
            }
            if (state is AuthLoadedState) {
              RouteGenerator.navigateToPageWithoutStack(
                context,
                Routes.homeRoute,
                arguments: state.user,
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              RouteGenerator.navigateToPageWithoutStack(
                                context,
                                Routes.onboardingRoute,
                              );
                            },
                            child: Icon(Icons.arrow_back_ios),
                          ),
                          SizedBox(height: 15),
                          Text(
                            welcomeLabel,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            loginSubtitleLabel,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 40),
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
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 3),
                          CustomTextformfield(
                            borderRadius: 8,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => email = value,
                            hintText: emailHint,
                            validator: (value) {
                              if (value!.isEmpty) return errorInvalidEmail;
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            passwordLabel,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 3),
                          BlocBuilder<PasswordBloc, PasswordState>(
                            builder: (context, state) {
                              return CustomTextformfield(
                                borderRadius: 8,
                                maxLines: 1,
                                obscureText: !state.isVisible,
                                onChanged: (value) => password = value,
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return errorInvalidPassword;
                                  return null;
                                },
                                hintText: passswordHint,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context.read<PasswordBloc>().add(
                                      TogglePasswordVisibility(),
                                    );
                                  },
                                  icon: Icon(
                                    state.isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
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
                                  onChanged: (value) =>
                                      setState(() => rememberMe = value!),
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(rememberLabel),
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
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              backgroundColor: primaryColor,
                              borderRadius: 8,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    LoginEvent(
                                      email: email!,
                                      password: password!,
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                signinLabel,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: secondaryColor,
                                ),
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
                                  RouteGenerator.navigateToPageWithoutStack(
                                    context,
                                    Routes.signupPageRoute,
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
                if (state is AuthLoadingState) backdropFilter(context),
              ],
            );
          },
        ),
      ),
    );
  }
}
