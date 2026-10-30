import 'package:base_project_flutter/models/booking_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('customer collection amount', () {
    test('collects gross fare, not the driver net earning', () {
      expect(collectibleBookingFare({
        'price_detail': {'estimatePrice': 273},
        'driver_earnings': '234.00',
        'Pending_cancellation_charges': 0,
      }), 273);
    });

    test('adds only pending cancellation charges', () {
      expect(collectibleBookingFare({
        'price_detail': {'estimatePrice': '273.50'},
        'Pending_cancellation_charges': '50',
        'cancellation_charges': 100,
      }), 323.5);
    });

    test('uses the server-discounted fare without applying coupons twice', () {
      expect(collectibleBookingFare({
        'price_detail': {'estimatePrice': 223},
        'subtotal': '273',
        'coupon_discount': 50,
      }), 223);
    });

    test('free rides still include outstanding collection charges', () {
      expect(collectibleBookingFare({
        'price_detail': {'estimatePrice': 0},
        'Pending_cancellation_charges': 25,
      }), 25);
    });

    test('rejects missing and malformed fare data', () {
      for (final booking in <Map<String, dynamic>>[
        {},
        {'price_detail': {'estimatePrice': 'bad'}},
        {'price_detail': {'estimatePrice': -1}},
        {'price_detail': {'estimatePrice': double.nan}},
      ]) {
        expect(() => collectibleBookingFare(booking), throwsFormatException);
      }
    });
  });

  group('joining fee routing', () {
    test('zero fee skips payment even when the stored payment flag is false', () {
      expect(requiresJoiningFee({'is_paid_joining_fee': false, 'joining_fee_amount': '0.00'}), isFalse);
    });
    test('already-paid drivers skip payment even for a positive fee', () {
      expect(requiresJoiningFee({'is_paid_joining_fee': true, 'joining_fee_amount': 500}), isFalse);
    });
    test('unpaid positive fees require payment', () {
      expect(requiresJoiningFee({'is_paid_joining_fee': false, 'joining_fee_amount': '500.50'}), isTrue);
    });
    test('missing fee never grants a payment exemption', () {
      expect(requiresJoiningFee({'is_paid_joining_fee': false}), isTrue);
    });
    test('invalid fees are surfaced', () {
      for (final amount in ['bad', -1, double.infinity]) {
        expect(() => requiresJoiningFee({'joining_fee_amount': amount}), throwsFormatException);
      }
    });
  });
}
