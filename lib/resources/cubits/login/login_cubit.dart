import 'dart:math';

import 'package:InstantMC/constants/enums/instantmc_connection_error_type.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../exceptions/instantmc_connection_error_exception.dart';
import '../../repositories/instantmc_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final InstantMCRepository _instantMCRepository;
  LoginCubit(this._instantMCRepository) : super(LoginInitial());

  String username = "";
  String password = "";

  void changeUsername(String newUsername) {
    username = newUsername;
    emit(LoginCredentialsChanged(username, password));
  }

  void changePassword(String newPassword) {
    password = newPassword;
    emit(LoginCredentialsChanged(username, password));
  }

  void login() async {
    emit(LoginStarted());
    try {
      final loginResponse = await _instantMCRepository.login(username, password);
      if(loginResponse.passwordChangeRequired) {
        emit(LoginSuccessPasswordChangeRequired(loginResponse.token));
      } else {
        emit(LoginSuccess(loginResponse.token));
      }
    } on DioError catch(e) {
      if(e.type == DioErrorType.connectionTimeout) {
        emit(LoginFailed(InstantMCConnectionErrorException("Connection timeout", InstantMCConnectionErrorType.connectTimeout)));
      } else if(e.type == DioErrorType.badResponse) {
        // wrong credentials
        emit(LoginFailed(InstantMCConnectionErrorException("Wrong credentials", InstantMCConnectionErrorType.wrongCredentials)));
      }
      print(e);
    } catch(e) {
      print(e);
    }
  }
}
