import 'dart:async';
import 'dart:convert';

import 'package:InstantMC/models/server_model.dart';
import 'package:InstantMC/models/server_resource_stats_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/instantmc_repository.dart';
import '../server/server_cubit.dart';

part 'server_stats_state.dart';

class ServerStatsCubit extends Cubit<ServerStatsState> {
  final InstantMCRepository _instantMCRepository;
  final ServerCubit _serverCubit;
  late final StreamSubscription _serverStream;

  ServerStatsCubit(this._instantMCRepository, this._serverCubit)
      : super(ServerStatsInitial()) {
    _serverStream = _serverCubit.stream.listen((serverState) {
      if (serverState is ServerDownloaded) {
        for (ServerModel serverModel in serverState.server) {
          subscribe(serverModel);
        }
      }
    });
  }

  final List<ServerModel> _subscribedServer = List.empty(growable: true);

  // String represents server ID
  final Map<String, List<ServerResourceStatsModel>> _subscribedServerData =
      <String, List<ServerResourceStatsModel>>{};

  void subscribe(ServerModel serverModel) async {
    emit(ServerStatsSubscribing(serverModel));

    final serverStatsStream =
    _instantMCRepository.subscribeServerStats(serverModel);
    serverStatsStream.listen(
            (dataList) {
          _subscribedServerData[serverModel.id] = dataList;

          emit(ServerStatsUpdated(
              serverModel, _subscribedServerData[serverModel.id]!));
        },
        cancelOnError: true,
        onDone: () {
          // Disconnected, trying to reconnect
          subscribe(serverModel);
        });
  }

  void _addServerToSubscribedList(ServerModel server) {
    _subscribedServer.add(server);
  }

  void _removeServerFromSubscribedList(ServerModel server) {
    _subscribedServer.removeWhere((element) => element.id == server.id);
  }

  @override
  Future<void> close() {
    _serverStream.cancel();
    return super.close();
  }
}
