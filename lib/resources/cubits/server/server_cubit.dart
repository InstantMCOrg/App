import 'dart:async';

import 'package:InstantMC/constants/enums/instantmc_connection_error_type.dart';
import 'package:InstantMC/resources/exceptions/instantmc_connection_error_exception.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../models/server_model.dart';
import '../../repositories/instantmc_repository.dart';
import '../user/user_cubit.dart';

part 'server_state.dart';

class ServerCubit extends Cubit<ServerState> {
  final InstantMCRepository _instantMCRepository;
  final UserCubit _userCubit;
  late final StreamSubscription _userStream;

  ServerCubit(this._instantMCRepository, this._userCubit) : super(ServerInitial()) {
    _userStream = _userCubit.stream.listen((userState) {
      if(userState is UserLoggedIn) {
        download();
      }
    });
  }

  void download() async {
    emit(ServerDownloading());
    try {
      final server = await _instantMCRepository.getServer();
      emit(ServerDownloaded(server));

    } on DioError catch(e) {
      if(e.type == DioErrorType.connectionTimeout) {
        emit(ServerDownloadError(InstantMCConnectionErrorException.fromType(InstantMCConnectionErrorType.connectTimeout)));
      } else {
        emit(ServerDownloadError(InstantMCConnectionErrorException.fromType(InstantMCConnectionErrorType.unknown)));
      }
      print(e);
    } catch(e) {
      print(e);
      emit(ServerDownloadError(InstantMCConnectionErrorException.fromType(InstantMCConnectionErrorType.unknown)));
    }
  }

  @override
  Future<void> close() {
    _userStream.cancel();
    return super.close();
  }
}
