import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yatra/features/auth/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yatra/features/auth/bloc/auth_event.dart';
import 'package:yatra/features/auth/bloc/auth_state.dart';




///password visibility bloc
class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(const PasswordInitialState()) {
    on<TogglePasswordVisibility>((event, emit) {
      if (state is PasswordUpdatedState) {
        emit(PasswordUpdatedState(!(state as PasswordUpdatedState).isVisible));
      } else {
        emit(const PasswordUpdatedState(true));
      }
    });
  }
}





class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitialState()) {
    on<SignupEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        QuerySnapshot userQuery = await firestore
            .collection('users')
            .where('email', isEqualTo: event.user.email)
            .get();
        if (userQuery.docs.isNotEmpty) {
          emit(AuthErrorState("Email already in use"));
          return;
        }

        emit(AuthLoadedState(event.user));
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });
   



    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {} catch (e) {
        emit(AuthErrorState("Something went wrong: ${e.toString()}"));
      }
    });
  }
}
