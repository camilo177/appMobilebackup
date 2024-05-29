part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested({required this.email, required this.password});
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});
}

class SignOutRequested extends AuthEvent {}
