class UserAuthRequiredTymerException implements Exception {}

class InvalidCredentialsTymerException implements Exception {}

class IncorrectPasswordTymerException implements Exception {}

class EmailNotRegisteredTymerException implements Exception {}

class ServiceRequestAlreadyProcessedTymerException implements Exception {}

class InvalidOtpTymerException implements Exception {}

class RateLimitedTymerException implements Exception {
  final int seconds;
  RateLimitedTymerException(this.seconds);
}

class ChatLimitReachedTymerException implements Exception {}

class InsufficientBalanceTymerException implements Exception {}

class StaleMinimumPriceTymerException implements Exception {}

class EmailAlreadyRegisteredTymerException implements Exception {}

class PhoneAlreadyRegisteredTymerException implements Exception {}

class PhoneNotRegisteredTymerException implements Exception {}

class InternetConnectionTymerException implements Exception {}

class PaymobTopUpFailedTymerException implements Exception {
  PaymobTopUpFailedTymerException(this.message);
  final String message;
}
