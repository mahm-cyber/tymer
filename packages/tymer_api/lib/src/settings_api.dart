import 'dart:async';
import 'package:dio/dio.dart';
import 'package:tymer_api/tymer_api.dart';

class SettingsApi {
  static const _dataJsonKey = 'data';
  static const _contentJsonKey = 'content';

  SettingsApi(
    this._dio,
    this._urlBuilder,
  );
  final Dio _dio;

  final UrlBuilder _urlBuilder;

  Future<PricingSettingsRM> getPricingSettings() async {
    final url = _urlBuilder.buildGetPricingSettingsUrl();
    try {
      final response = await _dio.get(url);
      final pricingSettings =
          PricingSettingsRM.fromJson(response.data[_dataJsonKey]);
      return pricingSettings;
    } catch (error) {
      rethrow;
    }
  }

  Future<TermsAndConditionsRM> getTermsAndConditions() async {
    final url = _urlBuilder.buildGetTermsAndConditionsUrl();
    try {
      final response = await _dio.get(url);
      final termsAndConditions = TermsAndConditionsRM.fromJson(
          response.data[_dataJsonKey][_contentJsonKey]);
      return termsAndConditions;
    } catch (error) {
      rethrow;
    }
  }

  Future<PrivacyPolicyRM> getPrivacyPolicy() async {
    final url = _urlBuilder.buildGetPrivacyPolicyUrl();
    try {
      final response = await _dio.get(url);
      final privacyPolicy = PrivacyPolicyRM.fromJson(
          response.data[_dataJsonKey][_contentJsonKey]);
      return privacyPolicy;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<FaqRM>> getFaqs() async {
    final url = _urlBuilder.buildGetFaqsUrl();
    try {
      final response = await _dio.get(url);
      final json = response.data[_dataJsonKey] as List;
      final faqs = json.map((e) => FaqRM.fromJson(e)).toList();
      return faqs;
    } catch (error) {
      rethrow;
    }
  }
}
