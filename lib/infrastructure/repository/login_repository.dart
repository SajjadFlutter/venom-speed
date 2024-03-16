import 'package:dio/dio.dart';

import '../../common/resources/data_state.dart';
import '../providers/login_api_provider.dart';

class LoginRepository {
  final LoginApiProvider apiProvider;

  LoginRepository(this.apiProvider);

  Future<dynamic> fetchServerData({
    required String email,
    required String password,
  }) async {
    try {
      Response response =
          await apiProvider.loginUser(email: email, password: password);
      if (response.statusCode == 200) {
        if (response.data['auth'] != null) {
          return DataSuccess(response.data['auth']);
        }
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }
}
