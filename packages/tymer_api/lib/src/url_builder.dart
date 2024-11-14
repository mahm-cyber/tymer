class UrlBuilder {
  UrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://api.tymer-eg.com/api/v1';

  final String _baseUrl;
  static const String _authSlug = 'auth';

  String buildSignInUrl() {
    final completeUrl = '$_baseUrl/$_authSlug/login';
    return completeUrl;
  }

  String buildGetUserUrl() {
    final completeUrl = '$_baseUrl/$_authSlug/me';
    return completeUrl;
  }

  String buildSignUpUrl() {
    final completeUrl = '$_baseUrl/$_authSlug/register';
    return completeUrl;
  }

  String buildSendOtpUrl() {
    final completeUrl = '$_baseUrl/$_authSlug/phone-number/resend-verification';
    return completeUrl;
  }

  String buildForgotPasswordUrl() {
    final completeUrl = '$_baseUrl/$_authSlug/forgot-password';
    return completeUrl;
  }

  String buildVerifyOtpUrl() {
    return '$_baseUrl/$_authSlug/phone-number/verify';
  }

  buildResetPasswordUrl() {
    return '$_baseUrl/resetPassword';
  }

  String buildRequestServiceUrl() {
    return '$_baseUrl/service-requests';
  }

  String buildGetReservationServiceTypesUrl() {
    return '$_baseUrl/reservation-service-categories?includeTranslations=true';
  }

  String buildGetAllServiceRequestsUrl(
      {required double lat,
      required double long,
      required String mode,
      String? status}) {
    final latQuery = '?user_lat=$lat';
    final longQuery = '&user_long=$long';
    final modeQuery = '&mode=$mode';
    const includeServiceQuery = '&include=service';
    final statusQuery = status != null ? '&status=$status' : '&status=pending';
    final completeUrl = '$_baseUrl/service-requests/list$latQuery'
        '$longQuery'
        '$modeQuery'
        '$includeServiceQuery'
        '$statusQuery';
    return completeUrl;
  }

  String buildAcceptServiceRequestUrl({
    required int serviceRequestId,
  }) {
    final completeUrl = '$_baseUrl/service-requests/$serviceRequestId/accept';
    return completeUrl;
  }
  String buildSubmitServiceRequestUrl({
    required int serviceRequestId,
  }) {
    final completeUrl = '$_baseUrl/service-requests/$serviceRequestId/submit-response';
    return completeUrl;
  }
}
