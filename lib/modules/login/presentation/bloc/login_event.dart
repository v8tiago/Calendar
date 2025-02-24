abstract class LoginEvent {}

class SignInRequested extends LoginEvent {
  final String email;

  SignInRequested({required this.email});
}