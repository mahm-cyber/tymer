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

  String buildReSendOtpUrl() {
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
    const includeSlug = 'include=service,serviceResponse,dispute';
    final completeUrl =
        '$baseUrl/service-requests/$serviceRequestId?$includeSlug';
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
    const includeQuery =
        '&include=serviceRequest,serviceRequest.service,serviceRequest.serviceResponse';
    final completeUrl =
        '$baseUrl/disputes$pageQuery$modeQuery$statusQuery$includeQuery';
    return completeUrl;
  }

  String buildGetDisputeUrl({
    required int disputeId,
    required String userType,
  }) {
    final completeUrl = '$baseUrl/disputes/$disputeId?mode=$userType';
    return completeUrl;
  }

  String buildGetDisputeChatUrl({
    required int disputeId,
    required String userType,
  }) {
    final urlLastSlug = userType == 'provider'
        ? 'selected-user-chat-messages'
        : 'chat-messages';
    final completeUrl = '$baseUrl/disputes/$disputeId/$urlLastSlug';
    return completeUrl;
  }

  String buildGetPricingSettingsUrl() {
    return '$baseUrl/settings/service-pricing';
  }

  String buildGetPaymentMethodsUrl(String paymentType) {
    return '$baseUrl/settings/$paymentType-requests';
  }

  String buildGetInAppTransactionsUrl({
    required int page,
  }) {
    return '$baseUrl/transactions?page=$page';
  }

  String buildConfirmTopUpUrl(String paymentMethodType) {
    return '$baseUrl/transactions/top-up/$paymentMethodType/requests';
  }

  String buildConfirmBankCardTopUpUrl() {
    return '$baseUrl/transactions/top-up/bank-card';
  }

  String buildConfirmWalletWithdrawUrl(String paymentMethodType) {
    return '$baseUrl/transactions/withdraw/$paymentMethodType/requests';
  }

  String buildSendChatMessageUrl({
    required int disputeId,
    required String userType,
  }) {
    final urlLastSlug = userType == 'provider'
        ? 'selected-user-chat-messages'
        : 'chat-messages';
    return '$baseUrl/disputes/$disputeId/$urlLastSlug';
  }

  String buildGetTermsAndConditionsUrl() {
    return '$baseUrl/settings/terms-of-service';
  }

  String buildGetPrivacyPolicyUrl() {
    return '$baseUrl/settings/privacy-policy';
  }

  String buildChangePasswordUrl() {
    return '$baseUrl/$_authSlug/update-password';
  }

  String buildChangePhoneUrl() {
    return '$baseUrl/$_authSlug/phone-number/request-update';
  }

  String buildVerifyOtpForChangePhoneUrl() {
    return '$baseUrl/$_authSlug/phone-number/update';
  }

  String buildSendFcmTokenUrl() {
    return '$baseUrl/$_authSlug/me/push-tokens';
  }

  String buildChangeLanguageUrl() {
    return '$baseUrl/$_authSlug/preferred-language';
  }

  String buildGetPaymentsUrl({
    required String type,
    required String paymentMethodType,
    required int page,
  }) {
    return '$baseUrl/transactions/$type/$paymentMethodType/requests?page=$page';
  }
}
