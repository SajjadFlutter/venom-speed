import 'package:dio/dio.dart';

class LoginApiProvider {
  final Dio dio;

  LoginApiProvider(this.dio);

  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await dio.post(
        'http://shaano.ir/api/login',
        data: {
          'email': email,
          'password': password,
          'token':
              r'$2y$10$/1CY5P6aO5DDDtIvCx9BEOkYtpdlKn7Nl8eJDVE8./TE9S1HQGfqi'
        },
      );
    } catch (e) {
      return;
    }
  }
}
