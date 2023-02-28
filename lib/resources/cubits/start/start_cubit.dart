import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import '../../repositories/storage_repository.dart';

part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  final StorageRepository _storageRepository;
  /// serverUrl is preserved for usage in web
  StartCubit(this._storageRepository, {String? serverUrl}) : super(StartInitial()) {
    if(serverUrl != null) {
      assert(kIsWeb);
      // we save the target url into storage so the user can skip the url step
      _storageRepository.saveTargetServerUrl(serverUrl).then((value) => init());
    } else {
      init();
    }
  }

  void init() async {
    emit(StartLoading());

    final String? targetServerUrl = await _storageRepository.getTargetServerUrl();
    final String? token = await _storageRepository.getToken();
    if(targetServerUrl == null) {
      // no server has been saved. We need to login first
      emit(StartServerUrlRequired());
      return;
    } else if(targetServerUrl != null && token != null) {
      emit(StartSavedServerFound(token, targetServerUrl));
    } else if(targetServerUrl != null && token == null) {
      emit(StartServerCredentialsRequired(targetServerUrl));
    }
  }
}
