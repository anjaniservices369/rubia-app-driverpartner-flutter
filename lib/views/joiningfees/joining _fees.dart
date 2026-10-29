// ----------------------------------------------------------------------
// Pay joining fee
//
// The driver pays the one-time joining fee through Razorpay Checkout or Cashfree and picks which one.
//
// Developer note: the server fixes the fee and creates the order (driver/razorpay-create-order,
// purpose joining_fee); the app opens Razorpay with it and then sends the result
// (razorpay_order_id, razorpay_payment_id, razorpay_signature) to driver/pay-joining-fee, which
// verifies it. Test or live mode is decided by the key the server returns. Cashfree works the same
// way (driver/cashfree-create-order, then pay-joining-fee with gateway=cashfree and the order id; the
// server reads the order back from Cashfree). PhonePe and Google Pay are offered inside Razorpay.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_services/userApi.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/leadingbackbtn.dart';
import '../../responsive.dart';
import '../profile_review/profile_review.dart';

// >>> START  class JoiningFees
class JoiningFees extends StatefulWidget {
  const JoiningFees({Key? key}) : super(key: key);

  @override
  State<JoiningFees> createState() => _JoiningFeesState();
}
// <<< END    class JoiningFees

// >>> START  class _JoiningFeesState
class _JoiningFeesState extends State<JoiningFees> {
  bool ischeckbox = false;
  final Razorpay _razorpay = Razorpay();
  final CFPaymentGatewayService _cashfree = CFPaymentGatewayService();
  // The gateway the driver picked: razorpay | cashfree.
  String _gateway = 'razorpay';
  // The joining fee set in the admin dashboard (driver/check -> joining_fee_amount); the screen no longer hard-codes it.
  String _fee = '';
  // The Submit button's spinner switch; it is stopped when the checkout closes or the payment is verified.
  VoidCallback? _stopSpinner;

  // >>> START  _JoiningFeesState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onExternalWallet);
    _cashfree.setCallback(_onCashfreeVerify, _onCashfreeError);
    _loadFee();
  }
  // <<< END    _JoiningFeesState.initState()

  // >>> START  _JoiningFeesState._loadFee()  -  load fee
  Future<void> _loadFee() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString('authCode');
      if (code == null) return;
      final check = await UserAPI().checkApi(code);
      final fee = check?['detail']?['joining_fee_amount'];
      if (fee != null && mounted) {
        final n = double.tryParse(fee.toString());
        setState(() => _fee = n == null ? fee.toString() : (n == n.roundToDouble() ? n.toInt().toString() : n.toStringAsFixed(2)));
      }
    } catch (_) {}
  }
  // <<< END    _JoiningFeesState._loadFee()

  // >>> START  _JoiningFeesState.dispose()  -  cleanup when the screen closes
  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
  // <<< END    _JoiningFeesState.dispose()

  // >>> START  _JoiningFeesState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.navigateBack(context);
          },
        ),
        // centerTitle: false,
        title: Text('Joining_fees'.tr,
            style: TextStyle(
                fontSize: isTab(context) ? 11.sp : 14.sp,
                color: tSecondaryColor,
                fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: tDefaultPadding),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    height: 30.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: tWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [tBoxShadow],
                        image: DecorationImage(
                            image: AssetImage(Images.JOININGIMGBACK),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text('Joining_fees'.tr,
                      style: GoogleFonts.mulish(
                          fontSize: isTab(context) ? 11.sp : 14.sp,
                          color: tSecondaryColor,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: tWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [tBoxShadow]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: tPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                      color: ischeckbox == true
                                          ? tPrimaryColor
                                          : tPrimaryColor,
                                      width: 0.6)),
                              value: ischeckbox,
                              onChanged: (bool? value) {
                                setState(() {
                                  ischeckbox = value!;
                                });
                              }),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              _fee.isEmpty ? 'Joining_fees'.tr : 'pay_joining_fee_amount'.tr.replaceAll('{amount}', _fee),
                              style: GoogleFonts.mulish(
                                  fontSize: isTab(context) ? 10.sp : 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: tSecondaryColor),
                            ),
                            Container(
                              width: 70.w,
                              child: Text(
                                "the_joining_fees _for_drivers_is_collected_to_cover_any_potential_damages,_violations,_orvunpaid_fees."
                                    .tr,
                                maxLines: 3,
                                style: GoogleFonts.mulish(
                                    fontSize: isTab(context) ? 8.sp : 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: tbrown),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text('pay_with'.tr,
                  style: GoogleFonts.mulish(
                      fontSize: isTab(context) ? 10.sp : 12.sp,
                      fontWeight: FontWeight.w700,
                      color: tSecondaryColor)),
            ),
            ListTile(
              leading: Icon(_gateway == 'razorpay' ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: tPrimaryColor),
              title: Text('Razorpay', style: TextStyle(color: tSecondaryColor, fontWeight: FontWeight.w700)),
              subtitle: Text('pay_with_razorpay_note'.tr),
              onTap: () => setState(() => _gateway = 'razorpay'),
            ),
            ListTile(
              leading: Icon(_gateway == 'cashfree' ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: tPrimaryColor),
              title: Text('Cashfree', style: TextStyle(color: tSecondaryColor, fontWeight: FontWeight.w700)),
              subtitle: Text('pay_with_cashfree_note'.tr),
              onTap: () => setState(() => _gateway = 'cashfree'),
            ),
            SizedBox(height: 1.h),
            Button(
                textcolor: tWhite,
                bottonText: 'submit'.tr,
                borderSide: BorderSide(
                  color: tPrimaryColor,
                ),
                onTap: (startLoading, stopLoading, btnState) async {
                  if (ischeckbox == true) {
                    startLoading();
                    _stopSpinner = stopLoading;
                    await _startPayment();
                  } else {
                    Twl.createAlert(
                        context, 'Alert', 'Joining fee is manditory');
                  }
                }),
            SizedBox(
              height: 2.h,
            ),
            Container(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "by_submission_you_agree_to_our".tr + " ",
                      style: GoogleFonts.mulish(
                        color: tSecondaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 8.sp : 10.sp,
                      ),
                    ),
                  ]),
            ),
            Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "terms_&_conditions".tr ,
                  style: GoogleFonts.mulish(
                    color: tPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: isTab(context) ? 8.sp : 10.sp,
                  ),
                ),
                Text(
                  "and".tr + " ",
                  style: GoogleFonts.mulish(
                    color: tSecondaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: isTab(context) ? 8.sp : 10.sp,
                  ),
                ),
                Text(
                  "privacy_policy".tr,
                  style: GoogleFonts.mulish(
                    color: tPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: isTab(context) ? 8.sp : 10.sp,
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
  // <<< END    _JoiningFeesState.build()

  // >>> START  _JoiningFeesState._startPayment()  -  start payment
  Future<void> _startPayment() async {
    if (_gateway == 'cashfree') {
      await _startCashfree();
      return;
    }
    final res = await DriverDetailsApi().createRazorpayOrderApi(context, {'purpose': 'joining_fee'});
    if (res == null || res['status'] != 'OK') {
      _stopSpinner?.call();
      Twl.createAlert(context, 'Oops', '${res?['error'] ?? 'Could not start the payment. Please try again.'}');
      return;
    }
    final o = res['details'];
    try {
      _razorpay.open({
        'key': o['key_id'],
        'amount': o['amount'],
        'currency': o['currency'] ?? 'INR',
        'name': o['name'] ?? 'Rubia Services',
        'description': o['description'] ?? 'Joining fee',
        'order_id': o['order_id'],
        'prefill': o['prefill'] ?? {},
        'theme': {'color': '#FF8C0A'},
      });
    } catch (e) {
      _stopSpinner?.call();
      Twl.createAlert(context, 'Oops', 'Could not open the payment screen: $e');
    }
  }
  // <<< END    _JoiningFeesState._startPayment()

  // >>> START  _JoiningFeesState._onPaymentSuccess()  -  on payment success
  void _onPaymentSuccess(PaymentSuccessResponse r) async {
    final res = await DriverDetailsApi().fetchJoiningFeeStatus(context, {
      'razorpay_order_id': r.orderId ?? '',
      'razorpay_payment_id': r.paymentId ?? '',
      'razorpay_signature': r.signature ?? '',
    });
    _stopSpinner?.call();
    if (!mounted) return;
    if (res != null && res['status'] == 'OK') {
      Twl.forceNavigateTo(context, ProfileReview());
    } else {
      Twl.createAlert(context, 'Oops',
          '${res?['error'] ?? 'We could not confirm the payment yet. If money was deducted, please contact support.'}');
    }
  }
  // <<< END    _JoiningFeesState._onPaymentSuccess()

  // >>> START  _JoiningFeesState._onPaymentError()  -  on payment error
  void _onPaymentError(PaymentFailureResponse r) {
    _stopSpinner?.call();
    if (!mounted) return;
    Twl.createAlert(context, 'Payment not completed', r.message ?? 'The payment was cancelled or failed. Please try again.');
  }
  // <<< END    _JoiningFeesState._onPaymentError()

  // >>> START  _JoiningFeesState._onExternalWallet()  -  on external wallet
  void _onExternalWallet(ExternalWalletResponse r) {
    _stopSpinner?.call();
  }
  // <<< END    _JoiningFeesState._onExternalWallet()

  // >>> START  _JoiningFeesState._startCashfree()  -  start cashfree
  Future<void> _startCashfree() async {
    final res = await DriverDetailsApi().createCashfreeOrderApi(context, {'purpose': 'joining_fee'});
    if (res == null || res['status'] != 'OK') {
      _stopSpinner?.call();
      Twl.createAlert(context, 'Oops', '${res?['error'] ?? 'Could not start the payment. Please try again.'}');
      return;
    }
    final o = res['details'];
    try {
      final session = CFSessionBuilder()
          .setEnvironment(o['mode'] == 'production' ? CFEnvironment.PRODUCTION : CFEnvironment.SANDBOX)
          .setOrderId(o['order_id'].toString())
          .setPaymentSessionId(o['payment_session_id'].toString())
          .build();
      _cashfree.doPayment(CFWebCheckoutPaymentBuilder().setSession(session).build());
    } on CFException catch (e) {
      _stopSpinner?.call();
      Twl.createAlert(context, 'Oops', e.message);
    }
  }
  // <<< END    _JoiningFeesState._startCashfree()

  // >>> START  _JoiningFeesState._onCashfreeVerify()  -  on cashfree verify
  void _onCashfreeVerify(String orderId) async {
    final res = await DriverDetailsApi().fetchJoiningFeeStatus(context, {'gateway': 'cashfree', 'orderId': orderId});
    _stopSpinner?.call();
    if (!mounted) return;
    if (res != null && res['status'] == 'OK') {
      Twl.forceNavigateTo(context, ProfileReview());
    } else {
      Twl.createAlert(context, 'Payment not completed',
          '${res?['error'] ?? 'We could not confirm the payment yet. If money was deducted, please contact support.'}');
    }
  }
  // <<< END    _JoiningFeesState._onCashfreeVerify()

  // >>> START  _JoiningFeesState._onCashfreeError()  -  on cashfree error
  void _onCashfreeError(CFErrorResponse e, String orderId) {
    _stopSpinner?.call();
    if (!mounted) return;
    Twl.createAlert(context, 'Payment not completed', e.getMessage() ?? 'The payment failed. Please try again.');
  }
  // <<< END    _JoiningFeesState._onCashfreeError()
}
// <<< END    class _JoiningFeesState
