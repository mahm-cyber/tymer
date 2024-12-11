class UrlBuilder {
  UrlBuilder();

  static const String baseUrl = 'https://api.tymer-eg.com/api/v1';
  static const String _authSlug = 'auth';

  String buildSignInUrl() {
    const completeUrl = '$baseUrl/$_authSlug/login';
    return completeUrl;
  }

  String buildSignOutUrl() {
    const completeUrl = '$baseUrl/$_authSlug/logout';
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
    return '$baseUrl/$_authSlug/reset-password';
  }

  String buildRequestServiceUrl() {
    return '$baseUrl/service-requests';
  }

  String buildGetReservationServiceTypesUrl() {
    return '$baseUrl/reservation-service-categories?includeTranslations=true';
  }

  String buildGetAllServiceRequestsUrl({
    int? page,
    required double lat,
    required double long,
    required String userType,
    String? status,
  }) {
    final latQuery = '?user_lat=$lat';
    final pageQuery = page != null ? '&page=$page' : '';
    final longQuery = '&user_long=$long';
    final modeQuery = '&mode=$userType';
    const includeServiceQuery = '&include=service,service.category';
    final statusQuery = status != null ? '&status=$status' : '&status=pending';
    const includeTranslationsQuery = '&includeTranslations=true';
    final completeUrl = '$baseUrl/service-requests/list$latQuery'
        '$longQuery'
        '$pageQuery'
        '$modeQuery'
        '$includeServiceQuery'
        '$includeTranslationsQuery'
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
        '$baseUrl/service-requests/$serviceRequestId?include=serviceResponse,service';
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

  String buildDisputeRequestUrl({
    required int serviceRequestId,
  }) {
    final completeUrl = '$baseUrl/service-requests/$serviceRequestId/dispute';
    return completeUrl;
  }

  String buildGetAllDisputesUrl({
    required int page,
    required String userType,
    String? status,
  }) {
    final pageQuery = '?page=$page';
    final modeQuery = '&mode=$userType';
    final statusQuery = status != null ? '&filter[status]=$status' : '';
    const includeQuery = '&include=serviceRequest,serviceRequest.service,serviceRequest.serviceResponse';
    final completeUrl = '$baseUrl/disputes$pageQuery$modeQuery$statusQuery$includeQuery';
    return completeUrl;
  }
}
