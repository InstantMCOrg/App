part of 'login_steps_switcher_cubit.dart';

@immutable
abstract class LoginStepsSwitcherState {}

class LoginStepsSwitcherUrlStep extends LoginStepsSwitcherState {}
class LoginStepsSwitcherCredentialsStep extends LoginStepsSwitcherState {}
class LoginStepsSwitcherCredentialsStepBlocked extends LoginStepsSwitcherState {}
