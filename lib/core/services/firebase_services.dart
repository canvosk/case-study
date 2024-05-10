import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseServices {
  final FirebaseRemoteConfig _firebaseRemoteConfig =
      FirebaseRemoteConfig.instance;

  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  static const String _baseUrl = "baseUrl";

  FirebaseServices() {
    init();
  }

  Future init() async {
    await _firebaseRemoteConfig.fetchAndActivate();
  }

  String? getUrl() {
    String baseUrl = _firebaseRemoteConfig.getString(_baseUrl);
    return baseUrl == "" ? null : baseUrl;
  }

  void logEvent() async {
    _firebaseAnalytics.logEvent(name: "sentAPIRequest");
  }
}
