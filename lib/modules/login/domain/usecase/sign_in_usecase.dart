import 'package:magic_calendar/modules/login/domain/repositories/user_repository.dart';

import '../entities/user.dart';

class SignInUseCase {
  final UserRepository repository;

  SignInUseCase({required this.repository});

  Future<User?> call(String email) async {
    return await repository.fetchUser(email);
  }
}