import 'package:dio/dio.dart';

import '../../common/resources/data_state.dart';
import '../models/server_model/server_model.dart';
import '../providers/server_api_provdier.dart';

class ServerRepository {
  final ServerApiProvider apiProvider;

  ServerRepository(this.apiProvider);

  Future<dynamic> fetchServerData() async {
    try {
      Response response = await apiProvider.getListServerConfigs();
      if (response.statusCode == 200) {
        ServerModel serverModel = ServerModel.fromJson(response.data);
        return DataSuccess(serverModel);
      } else {
        return const DataFailed('مشکلی پیش آمده، لطفا دوباره امتحان کنید.');
      }
    } catch (e) {
      return const DataFailed('لطفا اتصال خود را به اینترنت چک کنید.');
    }
  }
}
