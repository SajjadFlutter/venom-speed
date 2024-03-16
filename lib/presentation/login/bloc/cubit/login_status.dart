part of 'login_cubit.dart';

@immutable
abstract class LoginStatus {}

class LoginInitial extends LoginStatus {}

class LoadingLogin extends LoginStatus {}

class LoginOn extends LoginStatus {}

class LoginOff extends LoginStatus {}
