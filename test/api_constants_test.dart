// Checks the server addresses the app calls: the ones that need the login code end with ?auth_code=, and the
// payment endpoints used by the joining-fee screen exist.
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the default server address ends with a slash (endpoints are appended to it)', () {
    expect(apiBaseUrl.endsWith('/'), isTrue);
  });

  test('payment endpoints are the driver ones the backend serves', () {
    expect(RAZORPAY_CREATE_ORDER, 'driver/razorpay-create-order?auth_code=');
    expect(CASHFREE_CREATE_ORDER, 'driver/cashfree-create-order?auth_code=');
    expect(PAY_JOINING_FEE, 'driver/pay-joining-fee?auth_code=');
  });

  test('login-code endpoints end with ?auth_code= exactly once', () {
    for (final e in [
      UPDATE_PROFILE,
      PAY_JOINING_FEE,
      CREATE_ORDER,
      RAZORPAY_CREATE_ORDER,
      CASHFREE_CREATE_ORDER,
      LOGOUT,
      DELETE_ACCOUNT,
    ]) {
      expect(e.endsWith('?auth_code='), isTrue, reason: e);
      expect('?auth_code='.allMatches(e).length, 1, reason: e);
    }
  });

  test('payments stay in test mode unless the build asks for real money', () {
    expect(cashfreeProduction, isFalse);
  });
}
