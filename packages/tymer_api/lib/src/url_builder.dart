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

  String buildUpdateUserUrl() {
    final completeUrl = '$_baseUrl/updateUser';
    return completeUrl;
  }

  String buildUpdateAccountUrl() {
    final completeUrl = '$_baseUrl/update_user_setup';
    return completeUrl;
  }

  String buildChangePasswordUrl() {
    final completeUrl = '$_baseUrl/changePassword';
    return completeUrl;
  }

  buildResetPasswordUrl() {
    return '$_baseUrl/resetPassword';
  }
}
