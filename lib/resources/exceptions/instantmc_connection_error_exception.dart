import '../../constants/enums/instantmc_connection_error_type.dart';

class InstantMCConnectionErrorException implements Exception {
  String message;
  InstantMCConnectionErrorType type;
  InstantMCConnectionErrorException(this.message, this.type);

  InstantMCConnectionErrorException.fromType(InstantMCConnectionErrorType errorType) : type = errorType, message = errorType.errorMessage();
}