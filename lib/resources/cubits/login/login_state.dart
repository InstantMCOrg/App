part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginCredentialsChanged extends LoginState {
  final String username;
  final String password;

  const LoginCredentialsChanged(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class LoginStarted extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {
  final InstantMCConnectionErrorException error;

  const LoginFailed(this.error);

  @override
  List<Object> get props => [error];
}

class LoginSuccess extends LoginState {
  final String token;

  const LoginSuccess(this.token);

  @override
  List<Object> get props => [token];
}

class LoginSuccessPasswordChangeRequired extends LoginState {
  final String token;

  const LoginSuccessPasswordChangeRequired(this.token);
  @override
  List<Object> get props => [];
}
