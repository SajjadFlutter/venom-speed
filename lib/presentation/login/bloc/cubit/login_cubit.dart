import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../infrastructure/providers/login_api_provider.dart';
import '../../../../infrastructure/repository/login_repository.dart';

part 'login_state.dart';
part 'login_status.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository loginRepository = LoginRepository(LoginApiProvider(Dio()));
  LoginCubit() : super(LoginState(loginStatus: LoginInitial()));

  void checkLoginEvent(String email, String password) async {
    emit(state.copyWith(newLoginStatus: LoadingLogin()));

    final isLogin =
        await loginRepository.fetchServerData(email: email, password: password);

    if (isLogin != null) {
      emit(state.copyWith(newLoginStatus: LoginOn()));
    } else {
      emit(state.copyWith(newLoginStatus: LoginOff()));
    }
  }
}
