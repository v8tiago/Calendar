import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_calendar/core/widgets/cm_text_field.dart';
import 'package:magic_calendar/core/widgets/custom_button.dart';
import 'package:magic_calendar/modules/login/presentation/bloc/login_bloc.dart';
import 'package:magic_calendar/modules/login/presentation/bloc/login_event.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CmTextField(
            controller: _userController,
            hintText: 'Email',
            isPassword: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira seu email';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          CmTextField(
            controller: _passwordController,
            hintText: 'Senha',
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira sua senha';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: 'Entrar',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(
                      SignInRequested(email: _userController.text),
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}