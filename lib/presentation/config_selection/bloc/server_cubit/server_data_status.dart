part of 'server_cubit.dart';

@immutable
abstract class ServerDataStatus {}

class ServerDataLoading extends ServerDataStatus {}

class ServerDataCompleted extends ServerDataStatus {
  final ServerModel serverModel;

  ServerDataCompleted(this.serverModel);
}

class ServerDataError extends ServerDataStatus {
  final String errorMessage;

  ServerDataError(this.errorMessage);
}
