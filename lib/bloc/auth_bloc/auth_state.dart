part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.success(String userId) = _Success;
  const factory AuthState.fail() = _Fail;
}
