import 'package:dio/dio.dart';

class LoginApiProvider {
  final Dio dio;

  LoginApiProvider(this.dio);

  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      var response = await dio.post(
        r'http://shaano.ir/api/login?token=$2y$10$QSU8btqdlpbdv/J1rC/q0u42pHf0KrDZNeCteBF3jRZdR2XEY8tUG',
        data: {
          'email': email,
          'password': password,
        },
      );
      print(response.data['auth']);
      print(response.data);
      return (response);
    } catch (e) {
      return;
    }
  }
}
