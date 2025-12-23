import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yatra/features/auth/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yatra/features/auth/bloc/auth_event.dart';
import 'package:yatra/features/auth/bloc/auth_state.dart';

///password visibility bloc
class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitialState()) {
    on<TogglePasswordVisibility>((event, emit) {
      if (state is PasswordUpdatedState) {
        emit(PasswordUpdatedState(!(state as PasswordUpdatedState).isVisible));
      } else {
        emit(PasswordUpdatedState(true));
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
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: event.user.email!,
              password: event.password,
            );

        final uid = credential.user!.uid;
        event.user.uid = uid;
        await firestore.collection('users').doc(uid).set(event.user.toJson());

        emit(AuthLoadedState(event.user));
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: event.email,
              password: event.password,
            );

        final uid = credential.user!.uid;

        final doc = await firestore.collection('users').doc(uid).get();
        final user = AppUser.fromJson(doc.data()!);
        user.uid = uid;

        emit(AuthLoadedState(user));
      } on FirebaseAuthException catch (_) {
        emit(AuthErrorState("Invalid credentials"));
      } catch (e) {
        emit(AuthErrorState("Something went wrong"));
      }
    });
  }
}
