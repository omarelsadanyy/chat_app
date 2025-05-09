part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoading extends AuthState {}
final class RegisterSuccess extends AuthState {
  final String message;
  RegisterSuccess(this.message);
}
final class RegisterFailure extends AuthState {
  final String error;
  RegisterFailure(this.error);
}
final class RegisterPasswordVisisblity extends AuthState {
  final bool isPasswordVisible;
  RegisterPasswordVisisblity(this.isPasswordVisible);
}


final class LoginLoading extends AuthState {}
final class LoginSuccess extends AuthState {
  final String message;
  LoginSuccess(this.message);
}
final class LoginFailure extends AuthState {
  final String error;
  LoginFailure(this.error);
}
final class LoginPasswordVisisblity extends AuthState {
  final bool isPasswordVisible;
  LoginPasswordVisisblity(this.isPasswordVisible); 
}
