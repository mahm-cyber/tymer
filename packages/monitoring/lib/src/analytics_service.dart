import 'package:firebase_analytics/firebase_analytics.dart';

/// Wrapper around [FirebaseAnalytics].
class AnalyticsService {
  AnalyticsService() : _analytics = FirebaseAnalytics.instance {
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    FirebaseAnalytics.instance
        .setUserProperty(name: 'allow_personalized_ads', value: 'false');
  }

  final FirebaseAnalytics _analytics;

  Future<void> setCurrentScreen(String screenName) {
    return _analytics.logScreenView(
      screenName: screenName,
    );
  }

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) {
    return _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
