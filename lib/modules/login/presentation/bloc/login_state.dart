import '../../../../core/model/event.dart';
import '../../domain/entities/user.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;
  final Map<String, List<Event>> events;

  LoginSuccess({required this.user, required this.events});
}

class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}

class UserNotFound extends LoginState {}