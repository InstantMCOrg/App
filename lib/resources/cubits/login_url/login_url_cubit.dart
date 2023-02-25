import 'package:InstantMC/constants/enums/instantmc_connection_error_type.dart';
import 'package:InstantMC/resources/exceptions/instantmc_connection_error_exception.dart';
import 'package:InstantMC/ui/widgets/login/login_url_edit_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/instantmc_repository.dart';

part 'login_url_state.dart';

class LoginUrlCubit extends Cubit<LoginUrlState> {
  final InstantMCRepository _instantMCRepository;
  LoginUrlCubit(this._instantMCRepository) : super(LoginUrlInitial());

  String _url = LoginUrlEditWidget.initialValue;

  void textChanged(String newUrl) {
    emit(LoginUrlChanged(newUrl));
    _url = newUrl;
  }

  void check() async {
    emit(LoginUrlChecking(_url));
    final validUrl = InstantMCRepository.isUrlValid(_url);
    if(!validUrl) {
      emit(LoginUrlConnectionError(_url, InstantMCConnectionErrorException("'$_url' is not a valid URL", InstantMCConnectionErrorType.urlMalformed)));
      return;
    }
    _instantMCRepository.setTargetMachineUrl(_url);
    try {
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
    } catch(e) {
      emit(LoginUrlConnectionError(_url, InstantMCConnectionErrorException("Unknown error", InstantMCConnectionErrorType.unknown)));
    }
  }
}
