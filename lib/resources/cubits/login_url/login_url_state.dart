part of 'login_url_cubit.dart';

abstract class LoginUrlState extends Equatable {
  const LoginUrlState();
}

class LoginUrlInitial extends LoginUrlState {
  List<Object> get props => [];
}

class LoginUrlChanged extends LoginUrlState {
  final String url;

  const LoginUrlChanged(this.url);

  List<Object> get props => [url];
}

class LoginUrlChecking extends LoginUrlState {
  final String url;

  const LoginUrlChecking(this.url);

  List<Object> get props => [];
}

class LoginUrlConnectionError extends LoginUrlState {
  final String url;
  final InstantMCConnectionErrorException exception;

  const LoginUrlConnectionError(this.url, this.exception);

  List<Object> get props => [];
}

class LoginUrlConnectionSuccess extends LoginUrlState {
  final String url;
  final Uri uri;

  const LoginUrlConnectionSuccess(this.url, this.uri);

  List<Object> get props => [];
}
