import 'package:yatra/features/auth/model/user.dart';

abstract class AuthEvent {}

class SignupEvent extends AuthEvent {
  final AppUser user;
  final String password;
  SignupEvent({required this.user, required this.password});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

//password visibility
abstract class PasswordEvent {}

class TogglePasswordVisibility extends PasswordEvent {}
