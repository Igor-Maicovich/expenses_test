import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_expenses/bloc/auth_bloc/auth_bloc.dart';
import 'package:test_expenses/utils/test_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Log In', style: TestStyles().title),
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEvent.logIn());
          },
        ),
      ),
    );
  }
}
