class UserAuthRequiredException implements Exception {}

class InvalidCredentialsException implements Exception {}

class InvalidEmailFormatException implements Exception {}

class InvalidOtpException implements Exception {}

class OtpRateLimitExceededException implements Exception {
  final int seconds;
  OtpRateLimitExceededException(this.seconds);
}

class EmailNotRegisteredException implements Exception {}

class WrongPasswordException implements Exception {}

class EmailAlreadyRegisteredException implements Exception {}

class PhoneAlreadyRegisteredException implements Exception {}

class PhoneNotRegisteredException implements Exception {}
class InsufficientBalanceException implements Exception {}
class ServiceRequestAlreadyProcessed implements Exception {}
class StaleMinimumPriceException implements Exception {}

class PhoneNotVerifiedException implements Exception {}
