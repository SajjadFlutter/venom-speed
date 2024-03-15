import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/resources/data_state.dart';
import '../../../../infrastructure/models/server_model/server_model.dart';
import '../../../../infrastructure/repository/server_repository.dart';
part 'server_state.dart';
part 'server_data_status.dart';

class ServerCubit extends Cubit<ServerState> {
  final ServerRepository serverRepository;

  ServerCubit(this.serverRepository)
      : super(ServerState(serverDataStatus: ServerDataLoading()));

  Future<void> callServerDataEvent() async {
    // emit loading
    emit(state.copyWith(newServerDataStatus: ServerDataLoading()));

    final DataState dataState = await serverRepository.fetchServerData();

    if (dataState is DataSuccess) {
      // emit completed
      emit(state.copyWith(
          newServerDataStatus: ServerDataCompleted(dataState.data)));
    }

    if (dataState is DataFailed) {
      // emit error
      emit(state.copyWith(
          newServerDataStatus: ServerDataError(dataState.error!)));
    }
  }
}
