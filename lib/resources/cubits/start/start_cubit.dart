import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../repositories/storage_repository.dart';

part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  final StorageRepository _storageRepository;
  StartCubit(this._storageRepository) : super(StartInitial()) {
    init();
  }

  void init() async {
    emit(StartLoading());

    final String? targetServerUrl = await _storageRepository.getTargetServerUrl();
    if(targetServerUrl == null) {
      // no server has been saved. We need to login first
      emit(StartServerUrlRequired());
      return;
    }
  }
}
