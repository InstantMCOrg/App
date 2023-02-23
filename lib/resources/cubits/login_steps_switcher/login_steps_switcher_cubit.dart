import 'package:InstantMC/constants/enums/login_step.dart';
import 'package:InstantMC/ui/widgets/login_steps_switcher_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_steps_switcher_state.dart';

class LoginStepsSwitcherCubit extends Cubit<LoginStepsSwitcherState> {
  LoginStepsSwitcherCubit() : super(LoginStepsSwitcherUrlStep()); // TODO add test => LoginStepsSwitcherUrlStep() MUST be the initial value

  LoginStep _currentLoginStep = LoginStep.url;
  bool _stepSwitchToCredentialsAllowed = false;

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
}
