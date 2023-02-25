import 'dart:async';

import 'package:InstantMC/constants/enums/instantmc_connection_error_type.dart';
import 'package:InstantMC/resources/exceptions/instantmc_connection_error_exception.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../repositories/instantmc_repository.dart';
import '../user/user_cubit.dart';

part 'password_change_state.dart';

class PasswordChangeCubit extends Cubit<PasswordChangeState> {
  final InstantMCRepository _instantMCRepository;
  final UserCubit _userCubit;
  late final StreamSubscription _userStream;
  PasswordChangeCubit(this._instantMCRepository, this._userCubit) : super(PasswordChangeInitial()) {
    _userStream = _userCubit.stream.listen((userState) {

    });
  }

  void changePassword(String newPassword) async {
    emit(PasswordChanging());
    try {
      final newToken = await _instantMCRepository.changePassword(newPassword);
      emit(PasswordChangeSuccess(newToken));
    } on DioError catch(e) {
      if(e.type == DioErrorType.connectionTimeout) {
        emit(PasswordChangeFailed(InstantMCConnectionErrorException("Connection timeout", InstantMCConnectionErrorType.connectTimeout)));
      } else {
        emit(PasswordChangeFailed(InstantMCConnectionErrorException("Unknown", InstantMCConnectionErrorType.unknown)));
      }
    } catch(e) {
      emit(PasswordChangeFailed(InstantMCConnectionErrorException("Unknown", InstantMCConnectionErrorType.unknown)));
    }
  }

  @override
  Future<void> close() {
    _userStream.cancel();
    return super.close();
  }
}
