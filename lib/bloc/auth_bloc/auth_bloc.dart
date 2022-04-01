import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_expenses/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(const _Initial()) {
    on<_Check>((event, emit) async {
      var user = repository.checkUser();
      user != null ? emit(AuthState.success(user.uid)) : emit(const AuthState.fail());
    });
    on<_LogIn>((event, emit) async {
      var user = await repository.logIn();
      user != null ? emit(AuthState.success(user.uid)) : emit(const AuthState.fail());
    });
    on<_LogOut>((event, emit) async {
      var user = await repository.logOut();
      user != null ? emit(AuthState.success(user.uid)) : emit(const AuthState.fail());
    });
  }
}
