import 'package:yatra/features/auth/model/user.dart';

abstract class AuthEvent {}

class SignupEvent extends AuthEvent {
 final AppUser user;

  SignupEvent({required this.user});
}

class LoginEvent extends AuthEvent {}

//password visibility
abstract class PasswordEvent{}
class TogglePasswordVisibility extends PasswordEvent{}
