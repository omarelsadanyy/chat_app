part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
  final String message;
  LoginSuccess(this.message);
}
final class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}
final class LoginPasswordVisisblity extends LoginState {
  final bool isPasswordVisible;
  LoginPasswordVisisblity(this.isPasswordVisible); 
}
