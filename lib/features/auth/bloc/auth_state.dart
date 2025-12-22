import 'package:yatra/features/auth/model/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {
  final AppUser user;

  AuthLoadedState(this.user);
}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState(this.message);
}

//password visibility
abstract class PasswordState {
  final bool isVisible;
  const PasswordState(this.isVisible);
}

class PasswordInitialState extends PasswordState {
  const PasswordInitialState() : super(false); 
}

class PasswordUpdatedState extends PasswordState {
  const PasswordUpdatedState(bool isVisible) : super(isVisible);
}