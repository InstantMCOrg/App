part of 'start_cubit.dart';

@immutable
abstract class StartState {}

class StartInitial extends StartState {}
class StartLoading extends StartState {}
class StartServerUrlRequired extends StartState {}
class StartSavedServerFound extends StartState {
  final String token;
  final String url;

  StartSavedServerFound(this.token, this.url);
}

