import 'dart:async';

import 'package:InstantMC/constants/enums/login_step.dart';
import 'package:InstantMC/ui/widgets/login_steps_switcher_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../login_url/login_url_cubit.dart';

part 'login_steps_switcher_state.dart';

class LoginStepsSwitcherCubit extends Cubit<LoginStepsSwitcherState> {
  final LoginUrlCubit _loginUrlCubit;
  late final StreamSubscription _loginUrlEditStream;
  // TODO add test => LoginStepsSwitcherUrlStep() MUST be the initial value
  LoginStepsSwitcherCubit(this._loginUrlCubit) : super(LoginStepsSwitcherUrlStep()) {
    _loginUrlEditStream = _loginUrlCubit.stream.listen((loginUrlEditState) {
      if(loginUrlEditState is LoginUrlConnectionSuccess) {
        _stepSwitchToCredentialsAllowed = true;
        _switchToCredentialsStep();
      } else {
        _stepSwitchToCredentialsAllowed = false;
      }
    });
  }

  LoginStep _currentLoginStep = LoginStep.url;
  bool _stepSwitchToCredentialsAllowed = false;

  void _switchToCredentialsStep() {
    _currentLoginStep = LoginStep.credentials;
    emit(LoginStepsSwitcherCredentialsStep());
  }

  void toggle() {
    if(_currentLoginStep == LoginStep.url) {
      // TODO check if toggle is possible
      if(_stepSwitchToCredentialsAllowed) {
        _currentLoginStep = LoginStep.credentials;
        emit(LoginStepsSwitcherCredentialsStep());
      } else {
        emit(LoginStepsSwitcherCredentialsStepBlocked());
        Future.delayed(LoginStepsSwitcherWidget.switchNotAllowedAnimationDuration).then((_) {
          emit(LoginStepsSwitcherUrlStep());
        });
      }
    } else {
      _currentLoginStep = LoginStep.url;
      emit(LoginStepsSwitcherUrlStep());
    }
  }

  @override
  Future<void> close() {
    _loginUrlEditStream.cancel();
    return super.close();
  }
}
