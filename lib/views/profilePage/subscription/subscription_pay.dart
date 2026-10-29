// ----------------------------------------------------------------------
// Pay for the subscription plan
//
// A small sheet: shows the plan price, the driver picks Razorpay or Cashfree and pays. The price is set by
// the server from the active plan; the plan starts only after the server has checked the payment.
//
// Developer note: Razorpay: driver/razorpay-create-order (purpose=subscription) -> checkout -> driver/subscribe-now
// with the three razorpay_* fields. Cashfree: driver/cashfree-create-order -> checkout -> driver/subscribe-now with
// gateway=cashfree and the order id.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../api_services/DriverDetailApis.dart';
import '../../../constants/constants.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../responsive.dart';
import 'subscription.dart';

// >>> START  showSubscriptionPay()  -  show subscription pay
/// Opens the payment sheet for the plan costing [price] (display only; the server decides the real amount).
void showSubscriptionPay(BuildContext context, String price) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: tWhite,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => SubscriptionPay(price: price),
  );
}
// <<< END    showSubscriptionPay()

// >>> START  class SubscriptionPay
class SubscriptionPay extends StatefulWidget {
  const SubscriptionPay({Key? key, required this.price}) : super(key: key);
  final String price;

  @override
  State<SubscriptionPay> createState() => _SubscriptionPayState();
}
// <<< END    class SubscriptionPay

// >>> START  class _SubscriptionPayState
class _SubscriptionPayState extends State<SubscriptionPay> {
  final Razorpay _razorpay = Razorpay();
  final CFPaymentGatewayService _cashfree = CFPaymentGatewayService();
  String _gateway = 'razorpay';
  bool _busy = false;

  // >>> START  _SubscriptionPayState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onRazorpaySuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onRazorpayError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse r) => _setBusy(false));
    _cashfree.setCallback(_onCashfreeVerify, _onCashfreeError);
  }
  // <<< END    _SubscriptionPayState.initState()

  // >>> START  _SubscriptionPayState.dispose()  -  cleanup when the screen closes
  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
  // <<< END    _SubscriptionPayState.dispose()

  // >>> START  _SubscriptionPayState._setBusy()  -  set busy
  void _setBusy(bool v) {
    if (mounted) setState(() => _busy = v);
  }
  // <<< END    _SubscriptionPayState._setBusy()

  // >>> START  _SubscriptionPayState._start()
  Future<void> _start() async {
    _setBusy(true);
    final param = {'purpose': 'subscription'};
    final res = _gateway == 'cashfree'
        ? await DriverDetailsApi().createCashfreeOrderApi(context, param)
        : await DriverDetailsApi().createRazorpayOrderApi(context, param);
    if (res == null || res['status'] != 'OK') {
      _setBusy(false);
      if (mounted) Twl.createAlert(context, 'Oops', '${res?['error'] ?? 'Could not start the payment. Please try again.'}');
      return;
    }
    final o = res['details'];
    try {
      if (_gateway == 'cashfree') {
        final session = CFSessionBuilder()
            .setEnvironment(o['mode'] == 'production' ? CFEnvironment.PRODUCTION : CFEnvironment.SANDBOX)
            .setOrderId(o['order_id'].toString())
            .setPaymentSessionId(o['payment_session_id'].toString())
            .build();
        _cashfree.doPayment(CFWebCheckoutPaymentBuilder().setSession(session).build());
      } else {
        _razorpay.open({
          'key': o['key_id'],
          'amount': o['amount'],
          'currency': o['currency'] ?? 'INR',
          'name': o['name'] ?? 'Rubia Services',
          'description': o['description'] ?? 'Subscription',
          'order_id': o['order_id'],
          'prefill': o['prefill'] ?? {},
          'theme': {'color': '#FF8C0A'},
        });
      }
    } on CFException catch (e) {
      _setBusy(false);
      Twl.createAlert(context, 'Oops', e.message);
    } catch (e) {
      _setBusy(false);
      Twl.createAlert(context, 'Oops', 'Could not open the payment screen: $e');
    }
  }
  // <<< END    _SubscriptionPayState._start()

  // >>> START  _SubscriptionPayState._activate()
  Future<void> _activate(Map<String, String> proof) async {
    final res = await DriverDetailsApi().getDriverSubscription(context, proof);
    _setBusy(false);
    if (!mounted) return;
    if (res != null && res['status'] == 'OK') {
      Navigator.of(context).pop();
      Twl.forceNavigateTo(context, Subscription());
    } else {
      Twl.createAlert(context, 'Payment not completed',
          '${res?['error'] ?? 'We could not confirm the payment yet. If money was deducted, please contact support.'}');
    }
  }
  // <<< END    _SubscriptionPayState._activate()

  void _onRazorpaySuccess(PaymentSuccessResponse r) => _activate({
        'razorpay_order_id': r.orderId ?? '',
        'razorpay_payment_id': r.paymentId ?? '',
        'razorpay_signature': r.signature ?? '',
      });

  // >>> START  _SubscriptionPayState._onRazorpayError()  -  on razorpay error
  void _onRazorpayError(PaymentFailureResponse r) {
    _setBusy(false);
    if (mounted) Twl.createAlert(context, 'Payment not completed', r.message ?? 'The payment was cancelled or failed. Please try again.');
  }
  // <<< END    _SubscriptionPayState._onRazorpayError()

  void _onCashfreeVerify(String orderId) => _activate({'gateway': 'cashfree', 'orderId': orderId});

  // >>> START  _SubscriptionPayState._onCashfreeError()  -  on cashfree error
  void _onCashfreeError(CFErrorResponse e, String orderId) {
    _setBusy(false);
    if (mounted) Twl.createAlert(context, 'Payment not completed', e.getMessage() ?? 'The payment failed. Please try again.');
  }
  // <<< END    _SubscriptionPayState._onCashfreeError()

  // >>> START  _SubscriptionPayState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('subscription_plan'.tr,
                style: GoogleFonts.mulish(fontSize: isTab(context) ? 12.sp : 16.sp, fontWeight: FontWeight.w800, color: tSecondaryColor)),
            SizedBox(height: 1.h),
            Text('₹${widget.price}',
                style: GoogleFonts.mulish(fontSize: isTab(context) ? 14.sp : 22.sp, fontWeight: FontWeight.w800, color: tPrimaryColor)),
            SizedBox(height: 2.h),
            Text('pay_with'.tr,
                style: GoogleFonts.mulish(fontSize: isTab(context) ? 10.sp : 12.sp, fontWeight: FontWeight.w700, color: tSecondaryColor)),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(_gateway == 'razorpay' ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: tPrimaryColor),
              title: Text('Razorpay', style: TextStyle(color: tSecondaryColor, fontWeight: FontWeight.w700)),
              subtitle: Text('pay_with_razorpay_note'.tr),
              onTap: () => setState(() => _gateway = 'razorpay'),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(_gateway == 'cashfree' ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: tPrimaryColor),
              title: Text('Cashfree', style: TextStyle(color: tSecondaryColor, fontWeight: FontWeight.w700)),
              subtitle: Text('pay_with_cashfree_note'.tr),
              onTap: () => setState(() => _gateway = 'cashfree'),
            ),
            SizedBox(height: 1.h),
            SizedBox(
              width: double.infinity,
              height: 6.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: tPrimaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                onPressed: _busy ? null : _start,
                child: _busy
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                    : Text('subscribe_now'.tr, style: GoogleFonts.mulish(color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 13.sp)),
              ),
            ),
            SizedBox(height: 1.h),
          ],
        ),
      ),
    );
  }
  // <<< END    _SubscriptionPayState.build()
}
// <<< END    class _SubscriptionPayState
