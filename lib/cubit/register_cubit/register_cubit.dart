import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterPasswordVisisblity(isPasswordVisible));
  }
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
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
}
