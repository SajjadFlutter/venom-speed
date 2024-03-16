part of 'login_cubit.dart';

class LoginState {
  final LoginStatus loginStatus;

  LoginState({required this.loginStatus});

  LoginState copyWith({required LoginStatus? newLoginStatus}) {
    return LoginState(
      loginStatus: newLoginStatus ?? loginStatus,
    );
  }
}
