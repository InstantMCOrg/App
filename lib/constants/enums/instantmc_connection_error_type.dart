enum InstantMCConnectionErrorType {
  connectTimeout,
  noValidEndpoint,
  urlMalformed,
  wrongCredentials,
  unknown
}

extension InstantMCConnectionErrorTypeToMessage on InstantMCConnectionErrorType {
  String errorMessage() {
    switch(this) {
      case InstantMCConnectionErrorType.connectTimeout:
        return "Connection to server failed. Please try again.";
      case InstantMCConnectionErrorType.noValidEndpoint:
        return "No InstantMC installation has been found.";
      case InstantMCConnectionErrorType.urlMalformed:
        return "Not a valid url.";
      case InstantMCConnectionErrorType.wrongCredentials:
        return "Credentials incorrect.";
      default:
        return "An unknown error occurred. Please try again.";
    }
  }
}