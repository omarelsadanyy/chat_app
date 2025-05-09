import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isPasswordVisibleLogin = false;
  bool isPasswordVisibleRegister = false;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess('Login successful'));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure('No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure('Wrong password provided for that user.'));
          } else {
            emit(LoginFailure('An error occurred. Please try again.'));
          }
        } catch (e) {
          emit(LoginFailure('An error occurred. Please try again.'));
        }
      }

      if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email.trim(),
            password: event.password.trim(),
          );

          emit(RegisterSuccess('Registration successful'));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure('The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure('The account already exists for that email.'));
          } else {
            emit(RegisterFailure('An unknown error occurred.'));
          }
        } catch (e) {
          emit(RegisterFailure('An unknown error occurred.'));
        }
      }
      if (event is LoginPasswordVisibiltyEvent) {
        isPasswordVisibleLogin = !isPasswordVisibleLogin;
        emit(LoginPasswordVisisblity(isPasswordVisibleLogin));
      }

      if (event is RegisterPasswordVisibiltyEvent) {
         
         isPasswordVisibleRegister = !isPasswordVisibleRegister;
        emit(RegisterPasswordVisisblity(isPasswordVisibleRegister));
      }
    });
  }
}
