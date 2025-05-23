part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent{
  final String email;
  final String password;

  RegisterEvent({required this.email, required this.password});
}

class RegisterPasswordVisibiltyEvent extends AuthEvent{
 
}

class LoginPasswordVisibiltyEvent extends AuthEvent{
 
}
