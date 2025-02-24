import 'package:magic_calendar/modules/login/data/datasources/user_remote_datasource.dart';
import 'package:magic_calendar/modules/login/domain/repositories/user_repository.dart';

import '../../domain/entities/user.dart';


class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User?> fetchUser(String email) async {
    return await remoteDataSource.fetchUser(email);
  }
}