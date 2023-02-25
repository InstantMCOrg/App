part of 'start_cubit.dart';

@immutable
abstract class StartState {}

class StartInitial extends StartState {}
class StartLoading extends StartState {}
class StartServerUrlRequired extends StartState {}
/// In this case a server url was found in storage but no credentials
class StartServerCredentialsRequired extends StartState {
  final String targetUrl;

  StartServerCredentialsRequired(this.targetUrl);
}
class StartSavedServerFound extends StartState {
  final String token;
  final String url;

  StartSavedServerFound(this.token, this.url);
}

