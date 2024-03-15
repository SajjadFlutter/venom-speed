import 'package:dio/dio.dart';

class ServerApiProvider {
  final Dio dio;

  ServerApiProvider(this.dio);

  Future<dynamic> getListServerConfigs() async {
    try {
      Response response = await dio.get(
        r'http://shaano.ir/api/server/list?token=$2y$10$QSU8btqdlpbdv/J1rC/q0u42pHf0KrDZNeCteBF3jRZdR2XEY8tUG',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
