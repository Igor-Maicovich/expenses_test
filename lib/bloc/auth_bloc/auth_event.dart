part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.check() = _Check;
  const factory AuthEvent.logIn() = _LogIn;
  const factory AuthEvent.logOut() = _LogOut;
}
