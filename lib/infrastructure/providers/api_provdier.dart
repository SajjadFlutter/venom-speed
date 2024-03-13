import 'package:dio/dio.dart';

class ApiProvider {
  final Dio dio;

  ApiProvider(this.dio);

  Future<dynamic> getListServerConfigs() async {
    try {
      Response response = await dio.get(
        r'http://shaano.ir/api/server/list?token=$2y$10$6VKmuoVSbQEYoIonINBhiOxdiNbss9teuT8xU8210G1xIMeyQ/CEO',
      );
      print(response.data);
      return response;
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<dynamic> loginUser() async {
    try {
      final response = await dio.post(
        'http://shaano.ir/api/login',
        data: {
          'email': 'sajjad@gmail.com',
          'password': '12345678_',
          'token':
              '%242y%2410%246VKmuoVSbQEYoIonINBhiOxdiNbss9teuT8xU8210G1xIMeyQ%2FCEO%20GE'
        },
      );
      print(response.data);
      return response;
    } catch (e) {
      print('Error: $e');
    }
  }
}
