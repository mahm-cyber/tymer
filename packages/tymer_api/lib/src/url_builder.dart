class UrlBuilder {
  UrlBuilder({
    String? baseUrl,
  }) : _baseUrl = baseUrl ?? 'https://connect-in.io';

  final String _baseUrl;
  static const String _baseUrlSecondPart = 'wp-json/app/v1';


  String buildSignInUrl() {
    final completeUrl = '$_baseUrl/$_baseUrlSecondPart/login';
    return completeUrl;
  }

  String buildUpdateUserUrl() {
    final completeUrl = '$_baseUrl/$_baseUrlSecondPart/updateUser';
    return completeUrl;
  }

  String buildUpdateAccountUrl() {
    final completeUrl = '$_baseUrl/$_baseUrlSecondPart/update_user_setup';
    return completeUrl;
  }

  String buildChangePasswordUrl() {
    final completeUrl = '$_baseUrl/$_baseUrlSecondPart/changePassword';
    return completeUrl;
  }

  buildSendOtpUrl() {
    return '$_baseUrl/sendOtp';
  }
  buildVerifyOtpUrl() {
    return '$_baseUrl/verifyOtp';
  }

  buildResetPasswordUrl() {
    return '$_baseUrl/resetPassword';
  }
}
