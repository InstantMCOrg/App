part of 'password_change_cubit.dart';

@immutable
abstract class PasswordChangeState {}

class PasswordChangeInitial extends PasswordChangeState {}
class PasswordChanging extends PasswordChangeState {}
class PasswordChangeFailed extends PasswordChangeState {
  final InstantMCConnectionErrorException exception;

  PasswordChangeFailed(this.exception);
}
class PasswordChangeSuccess extends PasswordChangeState {
  final String newToken;

  PasswordChangeSuccess(this.newToken);
}
