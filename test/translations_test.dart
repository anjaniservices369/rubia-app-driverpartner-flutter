// Checks the on-screen text tables: every key must exist in all three languages, otherwise a screen shows the raw key name.
import 'package:base_project_flutter/views/translate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final keys = LanguageTranslations().keys;

  test('the three languages are present', () {
    expect(keys.keys, containsAll(['en_us', 'hi_in', 'tl_in']));
  });

  test('keys added for the registration and payment screens exist in every language', () {
    const added = [
      'login_or_register',
      'continue_text',
      'select_vehicle_type',
      'confirm_submit_fields',
      'pay_joining_fee_amount',
      'pay_with',
      'pay_with_razorpay_note',
      'pay_with_cashfree_note',
      'OTP_Verification',
      'sent_to',
      'first_name',
      'automatic',
      'manual',
    ];
    for (final lang in ['en_us', 'hi_in', 'tl_in']) {
      for (final k in added) {
        expect(keys[lang]!.containsKey(k), isTrue, reason: '$k is missing in $lang');
      }
    }
  });

  test('the joining-fee text keeps its {amount} placeholder in every language', () {
    for (final lang in ['en_us', 'hi_in', 'tl_in']) {
      expect(keys[lang]!['pay_joining_fee_amount'], contains('{amount}'), reason: lang);
    }
  });

  test('no key has an empty translation', () {
    for (final lang in keys.keys) {
      keys[lang]!.forEach((k, v) {
        expect(v.trim().isNotEmpty, isTrue, reason: '$k is empty in $lang');
      });
    }
  });
}
