part of 'start_cubit.dart';

@immutable
abstract class StartState {}

class StartInitial extends StartState {}
class StartLoading extends StartState {}
class StartServerUrlRequired extends StartState {}

