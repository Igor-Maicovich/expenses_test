import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_expenses/bloc/auth_bloc/auth_bloc.dart';
import 'package:test_expenses/presentation/screens/expenses_screen.dart';
import 'package:test_expenses/presentation/screens/login_screen.dart';
import 'package:test_expenses/presentation/screens/splash_screen.dart';
import 'package:test_expenses/repositories/auth_repo.dart';
import 'package:test_expenses/repositories/expense_repo.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses_Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveSizer(
        builder: (context, orientation, screenType) => BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => state.when(
              initial: () {
                context.read<AuthBloc>().add(const AuthEvent.check());
                return const SplashScreen();
              },
              success: (userId) => ExpensesScreen(
                repository: ExpenseRepository(userId),
              ),
              fail: () => const LoginScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
