import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_calendar/core/services/event_service.dart';
import 'package:magic_calendar/modules/home/home_page.dart';
import 'package:magic_calendar/modules/login/data/datasources/user_remote_datasource.dart';
import 'package:magic_calendar/modules/login/data/repositories/user_repository_impl.dart';
import 'package:magic_calendar/modules/login/domain/usecase/sign_in_usecase.dart';
import 'package:magic_calendar/modules/login/presentation/bloc/login_bloc.dart';
import 'package:magic_calendar/modules/login/presentation/bloc/login_state.dart';
import 'package:magic_calendar/modules/login/presentation/pages/user_not_found_page.dart';
import 'package:magic_calendar/modules/login/presentation/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(
          signInUseCase: SignInUseCase(
            repository: UserRepositoryImpl(
              remoteDataSource: UserRemoteDataSource(),
            ),
          ),
          fetchEventsUseCase: EventService(),
        );
      },
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  events: state.events,
                  user: state.user,
                ),
              ),
            );
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is UserNotFound) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserNotFoundPage(),
                ));
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Carregando...'),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 40,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 0),
                              Image.asset(
                                'lib/images/NA.jpg',
                                height: 120,
                              ),
                              Text(
                                'Bem vindo ao Calendário Mágico!',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 50),
                              LoginForm(),
                              Text(
                                'Esqueceu a senha?',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Não é um membro?',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Entre em contato!',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
