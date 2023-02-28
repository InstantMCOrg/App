part of 'server_cubit.dart';

@immutable
abstract class ServerState {}

class ServerInitial extends ServerState {}
class ServerDownloading extends ServerState {}
class ServerDownloadError extends ServerState {
  final InstantMCConnectionErrorException exception;

  ServerDownloadError(this.exception);
}
class ServerDownloaded extends ServerState {
  final List<ServerModel> server;

  ServerDownloaded(this.server);
}