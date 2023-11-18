import 'package:firebase_analytics/firebase_analytics.dart';

class MyAnalyticsHelper {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> textEventLog(_value) async {
    await analytics.logEvent(name: "${_value}_click", parameters: {"Value": _value}); 
    print("Send Event");
  }

  Future<void> testSetUserId(_value) async {
    await analytics.setUserId(id: _value);
    print('setUserId succeeded');
  }

  Future<void> testSetUserProperty() async {
    await analytics.setUserProperty(name: 'regular', value: 'indeed');
    print('setUserProperty succeeded');
  }

  Future<void> testSetSessionTimeoutDuration(_duration) async {
    await analytics.setSessionTimeoutDuration(Duration(seconds: _duration));
    print('setSessionTimeoutDuration in $_duration');
  }

  Future<void> testAppInstanceId() async {
    var instance = await analytics.appInstanceId;
    print('appInstanceId $instance');
  }

  Future<void> resetAnalyticsData() async {
    await analytics.resetAnalyticsData();
    print('analytics data reseted');
  }

  Future<void> logAddPaymentInfo() async {
    await analytics.logAddPaymentInfo(coupon: "ABC0347");
    print('log payment info');
  }

  Future<void> logAddToCart() async {
    await analytics.logAddToCart();
    print('log add to cart');
  }

  Future<void> logPurchase() async {
    await analytics.logPurchase();
    print('log purchase');
  }
}


// cd C:\Users\HP\AppData\Local\Androis\Sdk\platform-tools

// adb shell setprop debug.firebase.analytics.app com.example.case_study_latihan