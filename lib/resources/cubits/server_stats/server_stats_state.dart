part of 'server_stats_cubit.dart';

abstract class ServerStatsState extends Equatable {
  const ServerStatsState();
}

class ServerStatsInitial extends ServerStatsState {
  @override
  List<Object> get props => [];
}

class ServerStatsSubscribing extends ServerStatsState {
  final ServerModel serverModel;

  const ServerStatsSubscribing(this.serverModel);

  @override
  List<Object> get props => [serverModel.hashCode];
}

class ServerStatsUpdated extends ServerStatsState {
  final ServerModel serverModel;
  final List<ServerResourceStatsModel> stats;

  const ServerStatsUpdated(this.serverModel, this.stats);

  @override
  List<Object> get props => [serverModel.hashCode, stats.hashCode];
}
