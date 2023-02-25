part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class UserLoggedIn extends UserState {
  final String token;

  UserLoggedIn(this.token);
}
