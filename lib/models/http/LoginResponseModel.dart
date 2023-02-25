class LoginResponseModel {
  final String token;
  final bool passwordChangeRequired;

  const LoginResponseModel(this.token, this.passwordChangeRequired);
}