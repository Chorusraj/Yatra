import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:yatra/core/constants/app_color.dart';
import 'package:yatra/core/constants/app_string.dart';
import 'package:yatra/core/utils/route_generator.dart';
import 'package:yatra/core/utils/routes.dart';
import 'package:yatra/features/auth/bloc/auth_bloc.dart';
import 'package:yatra/features/auth/bloc/auth_event.dart';
import 'package:yatra/features/auth/bloc/auth_state.dart';
import 'package:yatra/features/auth/model/user.dart';
import 'package:yatra/features/auth/pages/login_page.dart';
import 'package:yatra/features/auth/pages/signup_page1.dart';
import 'package:yatra/features/widgets/custom_button.dart';
import 'package:yatra/features/widgets/custom_textform.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  String? firstName, lastName, phoneNumber, address, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is AuthLoadedState) {
                    RouteGenerator.navigateToPageWithoutStack(
                      context,
                      Routes.signupPage1Route,
                      arguments: state.user,
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(onTap: () {}, child: Icon(Icons.arrow_back_ios)),
                    SizedBox(height: 15),
                    Text(
                      createAccountLabel,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      signupSubtitleLabel,
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    SizedBox(height: 25),
                    Text(
                      firstNameLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 3),
                    CustomTextformfield(
                      borderRadius: 8,
                      onChanged: (value) {
                        firstName = value;
                      },
                      hintText: firstNameHint,
                      labelStyle: TextStyle(color: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return errorInvalidFirstName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      lastNameLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextformfield(
                      borderRadius: 8,
                      onChanged: (value) {
                        lastName = value;
                      },
                      hintText: lastNameHint,
                      labelStyle: TextStyle(color: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return errorInvalidLastName;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      phoneNumberLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 3),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        counterText: "",
                        hintText: phoneNumberHint2,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      // Start with a default country
                      initialCountryCode: 'US',
                      // Called whenever user types
                      onChanged: (phone) {
                        phoneNumber = phone.completeNumber; // +15551234567
                        print(phone.completeNumber);
                      },
                      // Called when the user selects new country code
                      onCountryChanged: (country) {
                        print(
                          'Country changed to: ${country.name} (${country.dialCode})',
                        );
                      },
                      // Optional validation
                      validator: (value) {
                        if (value == null || value.number.isEmpty) {
                          return errorInvalidPhoneNumber;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      addressLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextformfield(
                      borderRadius: 8,
                      onChanged: (value) {
                        address = value;
                      },
                      hintText: addressHint,
                      labelStyle: TextStyle(color: Colors.grey),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return errorInvalidAddress;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      emailLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 3),
                    CustomTextformfield(
                      keyboardType: TextInputType.emailAddress,
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
                    SizedBox(height: 15),
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
                    SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        backgroundColor: primaryColor,
                        borderRadius: 8,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final AppUser  user = AppUser(
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              password: password,
                              address: address,
                              phone: Phone(
                                countryCode: "+1", // or from IntlPhoneField
                                number: phoneNumber,
                              ),
                            );

                            context.read<AuthBloc>().add(
                              SignupEvent(user: user),
                            );
                          }
                        },
                        child: Text(
                          continueLabel,
                          style: TextStyle(fontSize: 16, color: secondaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          alreadyHaveAccountLabel,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            signinLabel,
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
      ),
    );
  }
}
