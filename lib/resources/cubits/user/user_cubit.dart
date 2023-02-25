import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/instantmc_repository.dart';
import '../../repositories/storage_repository.dart';
import '../start/start_cubit.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final InstantMCRepository _instantMCRepository;
  final StorageRepository _storageRepository;
  final StartCubit _startCubit;
  late final StreamSubscription _startStream;
  UserCubit(this._instantMCRepository, this._storageRepository, this._startCubit) : super(UserInitial()) {
    _startStream = _startCubit.stream.listen((startState) {
      if(startState is StartSavedServerFound) {
        _instantMCRepository.setTargetMachineUrl(startState.url);
        login(startState.token);
      }
    });
  }

  String _token = "";
  void login(String token) {
    _token = token;
    _instantMCRepository.setToken(token);
    _storageRepository.saveToken(token);
    _storageRepository.saveTargetServerUrl(_instantMCRepository.targetMachineUrl);
    emit(UserLoggedIn(token));
  }

  @override
  Future<void> close() {
    _startStream.cancel();
    return super.close();
  }
}
