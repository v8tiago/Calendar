
class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

// class LoginUseCase implements UseCase<LoginParams, UserCredential?> {
//   final FirebaseAuthDatasource datasource;

//   LoginUseCase({required this.datasource});

//   @override
//   Future<UserCredential?> call(LoginParams params) async {
//     return await datasource.loginWithEmailAndPassword(
//       params.email,
//       params.password,
//     );
//   }
// }