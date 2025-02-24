import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> fetchUser(String email);
}