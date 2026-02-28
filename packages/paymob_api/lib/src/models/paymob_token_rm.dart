class PaymobTokenRM {
  const PaymobTokenRM({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
    this.refreshToken,
    this.scope,
  });

  static const _accessTokenKey = 'access_token';
  static const _expiresInKey = 'expires_in';
  static const _tokenTypeKey = 'token_type';
  static const _refreshTokenKey = 'refresh_token';
  static const _scopeKey = 'scope';

  final String accessToken;
  final int expiresIn;
  final String tokenType;
  final String? refreshToken;
  final String? scope;

  factory PaymobTokenRM.fromJson(Map<String, dynamic> json) {
    return PaymobTokenRM(
      accessToken: json[_accessTokenKey] as String,
      expiresIn: json[_expiresInKey] as int,
      tokenType: json[_tokenTypeKey] as String,
      refreshToken: json[_refreshTokenKey] as String?,
      scope: json[_scopeKey] as String?,
    );
  }
}
