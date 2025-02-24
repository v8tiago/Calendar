import '../../domain/entities/user.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({required this.user});
}

class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}

class UserNotFound extends LoginState {}