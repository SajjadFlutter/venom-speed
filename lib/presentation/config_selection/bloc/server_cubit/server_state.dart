part of 'server_cubit.dart';

class ServerState {
  final ServerDataStatus serverDataStatus;

  ServerState({required this.serverDataStatus});

  ServerState copyWith({required ServerDataStatus? newServerDataStatus}) {
    return ServerState(
        serverDataStatus: newServerDataStatus ?? serverDataStatus);
  }
}
