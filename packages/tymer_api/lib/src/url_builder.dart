class UrlBuilder {
  UrlBuilder();

  static const String baseUrl = 'https://api.tymer-eg.com/api/v1';
  static const String _authSlug = 'auth';

  String buildSignInUrl() {
    const completeUrl = '$baseUrl/$_authSlug/login';
    return completeUrl;
  }

  String buildGetUserUrl() {
    const completeUrl = '$baseUrl/$_authSlug/me';
    return completeUrl;
  }

  String buildSignUpUrl() {
    const completeUrl = '$baseUrl/$_authSlug/register';
    return completeUrl;
  }

  String buildSendOtpUrl() {
    const completeUrl = '$baseUrl/$_authSlug/phone-number/resend-verification';
    return completeUrl;
  }

  String buildForgotPasswordUrl() {
    const completeUrl = '$baseUrl/$_authSlug/forgot-password';
    return completeUrl;
  }

  String buildVerifyOtpUrl() {
    return '$baseUrl/$_authSlug/phone-number/verify';
  }

  buildResetPasswordUrl() {
    return '$baseUrl/resetPassword';
  }

  String buildRequestServiceUrl() {
    return '$baseUrl/service-requests';
  }

  String buildGetReservationServiceTypesUrl() {
    return '$baseUrl/reservation-service-categories?includeTranslations=true';
  }

  String buildGetAllServiceRequestsUrl({
    required double lat,
    required double long,
    required String mode,
    String? status,
  }) {
    final latQuery = '?user_lat=$lat';
    final longQuery = '&user_long=$long';
    final modeQuery = '&mode=$mode';
    const includeServiceQuery = '&include=service';
    final statusQuery = status != null ? '&status=$status' : '&status=pending';
    final completeUrl = '$baseUrl/service-requests/list$latQuery'
        '$longQuery'
        '$modeQuery'
        '$includeServiceQuery'
        '$statusQuery';
    return completeUrl;
  }

  String buildAcceptServiceRequestUrl({
    required int serviceRequestId,
  }) {
    final completeUrl = '$baseUrl/service-requests/$serviceRequestId/accept';
    return completeUrl;
  }

  String buildSubmitServiceRequestUrl({
    required int serviceRequestId,
  }) {
    final completeUrl =
        '$baseUrl/service-requests/$serviceRequestId/submit-response';
    return completeUrl;
  }

  String buildGetServiceRequestUrl({
    required int serviceRequestId,
  }) {
    final completeUrl =
        '$baseUrl/service-requests/$serviceRequestId?include=serviceResponse';
    return completeUrl;
  }

  String buildConfirmServiceRequestUrl({
    required int serviceRequestId,
  }) {
    final completeUrl = '$baseUrl/service-requests/$serviceRequestId/confirm';
    return completeUrl;
  }

  String buildCancelServiceRequestUrl({
    required int serviceRequestId,
  }) {
    final completeUrl = '$baseUrl/service-requests/$serviceRequestId/cancel';
    return completeUrl;
  }
}
