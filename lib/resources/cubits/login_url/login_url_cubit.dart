import 'dart:async';

import 'package:InstantMC/constants/enums/instantmc_connection_error_type.dart';
import 'package:InstantMC/resources/exceptions/instantmc_connection_error_exception.dart';
import 'package:InstantMC/ui/widgets/login/login_url_edit_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../repositories/instantmc_repository.dart';
import '../start/start_cubit.dart';

part 'login_url_state.dart';

class LoginUrlCubit extends Cubit<LoginUrlState> {
  final InstantMCRepository _instantMCRepository;
  final StartCubit _startCubit;
  late final StreamSubscription _startStream;
  LoginUrlCubit(this._instantMCRepository, this._startCubit) : super(LoginUrlInitial()) {
    _startStream = _startCubit.stream.listen((startState) {
      if(startState is StartServerCredentialsRequired) {
        textChanged(startState.targetUrl);
        emit(LoginUrlConnectionSuccess(startState.targetUrl, Uri.parse(startState.targetUrl)));
      }
    });
  }

  String _url = LoginUrlEditWidget.initialValue;

  void textChanged(String newUrl) {
    _url = newUrl;
    emit(LoginUrlChanged(_url));
  }

  void check() async {
    emit(LoginUrlChecking(_url));
    // an slash ('/') can cause errors
    if(_url.endsWith("/")) {
      _url = _url.substring(0, _url.length - 1);
    }
    textChanged(_url);
    final validUrl = InstantMCRepository.isUrlValid(_url);
    if(!validUrl) {
      emit(LoginUrlConnectionError(_url, InstantMCConnectionErrorException("'$_url' is not a valid URL", InstantMCConnectionErrorType.urlMalformed)));
      return;
    }
    _instantMCRepository.setTargetMachineUrl(_url);
    try {
      if(kDebugMode) {
        print("Trying to connect to $_url...");
      }
      final isValidInstantMCEndpoint = await _instantMCRepository.isInstantMCAtUrlEndpoint();
      if(isValidInstantMCEndpoint) {
        emit(LoginUrlConnectionSuccess(_url, Uri.parse(_url)));
      } else {
        emit(LoginUrlConnectionError(_url, InstantMCConnectionErrorException("No valid endpoint", InstantMCConnectionErrorType.noValidEndpoint)));
      }
      return;
    } on DioError catch(e) {
      if(e.type == DioErrorType.connectionTimeout) {
        emit(LoginUrlConnectionError(_url, InstantMCConnectionErrorException("Connection timeout", InstantMCConnectionErrorType.connectTimeout)));
        return;
      } else if(e.type == DioErrorType.badResponse) {
        emit(LoginUrlConnectionError(_url, InstantMCConnectionErrorException("No valid endpoint", InstantMCConnectionErrorType.noValidEndpoint)));
      } else {
        emit(LoginUrlConnectionError(_url, InstantMCConnectionErrorException("Unknown error", InstantMCConnectionErrorType.unknown)));
      }
      print(e);
    } catch(e) {
      emit(LoginUrlConnectionError(_url, InstantMCConnectionErrorException("Unknown error", InstantMCConnectionErrorType.unknown)));
    }
  }

  @override
  Future<void> close() {
    _startStream.cancel();
    return super.close();
  }
}
