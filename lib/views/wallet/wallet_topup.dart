// ----------------------------------------------------------------------
// Add money to the wallet
//
// A small sheet: the driver types an amount, picks Razorpay or Cashfree and pays. The server creates
// the order, checks the payment with the gateway and only then credits the wallet.
//
// Developer note: Razorpay: driver/razorpay-create-order (purpose=wallet_topup, amount) -> checkout ->
// driver/add-balance with razorpay_order_id / razorpay_payment_id / razorpay_signature.
// Cashfree: driver/cashfree-create-order -> checkout -> driver/add-balance with gateway=cashfree and
// the order id. The amount credited is what the gateway reports, never the number typed here.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

import '../../api_services/DriverDetailApis.dart';
import '../../api_services/rideBookingsApi.dart';
import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../responsive.dart';
import '../bottomNavigation.dart/bottomNavigation.dart';

// >>> START  showWalletTopUp()  -  show wallet top up
/// Opens the top-up sheet from the wallet screen.
void showWalletTopUp(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: tWhite,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => const WalletTopUp(),
  );
}
// <<< END    showWalletTopUp()

// >>> START  class WalletTopUp
class WalletTopUp extends StatefulWidget {
  const WalletTopUp({Key? key}) : super(key: key);

  @override
  State<WalletTopUp> createState() => _WalletTopUpState();
}
// <<< END    class WalletTopUp

// >>> START  class _WalletTopUpState
class _WalletTopUpState extends State<WalletTopUp> {
  final Razorpay _razorpay = Razorpay();
  final CFPaymentGatewayService _cashfree = CFPaymentGatewayService();
  final TextEditingController _amount = TextEditingController();
  String _gateway = 'razorpay';
  bool _busy = false;

  // >>> START  _WalletTopUpState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onRazorpaySuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onRazorpayError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse r) => _setBusy(false));
    _cashfree.setCallback(_onCashfreeVerify, _onCashfreeError);
  }
  // <<< END    _WalletTopUpState.initState()

  // >>> START  _WalletTopUpState.dispose()  -  cleanup when the screen closes
  @override
  void dispose() {
    _razorpay.clear();
    _amount.dispose();
    super.dispose();
  }
  // <<< END    _WalletTopUpState.dispose()

  // >>> START  _WalletTopUpState._setBusy()  -  set busy
  void _setBusy(bool v) {
    if (mounted) setState(() => _busy = v);
  }
  // <<< END    _WalletTopUpState._setBusy()

  // >>> START  _WalletTopUpState._start()
  Future<void> _start() async {
    final a = double.tryParse(_amount.text.trim());
    if (a == null || a < 1 || a > 50000) {
      Twl.createAlert(context, 'Oops', 'Enter an amount between 1 and 50000 rupees.');
      return;
    }
    FocusScope.of(context).unfocus();
    _setBusy(true);
    final param = {'purpose': 'wallet_topup', 'amount': _amount.text.trim()};
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
          'description': o['description'] ?? 'Wallet top-up',
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
  // <<< END    _WalletTopUpState._start()

  // >>> START  _WalletTopUpState._credit()
  Future<void> _credit(Map<String, String> proof) async {
    final res = await RideBookingsApi().getAddMoneyWallet(context, proof);
    _setBusy(false);
    if (!mounted) return;
    if (res != null && res['status'] == 'OK') {
      Navigator.of(context).pop();
      Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 2));
    } else {
      Twl.createAlert(context, 'Payment not completed',
          '${res?['error'] ?? 'We could not confirm the payment yet. If money was deducted, please contact support.'}');
    }
  }
  // <<< END    _WalletTopUpState._credit()

  void _onRazorpaySuccess(PaymentSuccessResponse r) => _credit({
        'razorpay_order_id': r.orderId ?? '',
        'razorpay_payment_id': r.paymentId ?? '',
        'razorpay_signature': r.signature ?? '',
      });

  // >>> START  _WalletTopUpState._onRazorpayError()  -  on razorpay error
  void _onRazorpayError(PaymentFailureResponse r) {
    _setBusy(false);
    if (mounted) Twl.createAlert(context, 'Payment not completed', r.message ?? 'The payment was cancelled or failed. Please try again.');
  }
  // <<< END    _WalletTopUpState._onRazorpayError()

  void _onCashfreeVerify(String orderId) => _credit({'gateway': 'cashfree', 'orderId': orderId});

  // >>> START  _WalletTopUpState._onCashfreeError()  -  on cashfree error
  void _onCashfreeError(CFErrorResponse e, String orderId) {
    _setBusy(false);
    if (mounted) Twl.createAlert(context, 'Payment not completed', e.getMessage() ?? 'The payment failed. Please try again.');
  }
  // <<< END    _WalletTopUpState._onCashfreeError()

  // >>> START  _WalletTopUpState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Balance'.tr,
                  style: GoogleFonts.mulish(
                      fontSize: isTab(context) ? 12.sp : 16.sp, fontWeight: FontWeight.w800, color: tSecondaryColor)),
              SizedBox(height: 2.h),
              TextField(
                controller: _amount,
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
                style: TextStyle(fontWeight: FontWeight.w700, color: tSecondaryColor, fontSize: 18),
                decoration: InputDecoration(
                  prefixText: '₹ ',
                  hintText: 'enter_amount'.tr,
                  filled: true,
                  fillColor: tBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  onPressed: _busy ? null : _start,
                  child: _busy
                      ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                      : Text('Add'.tr, style: GoogleFonts.mulish(color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 13.sp)),
                ),
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
  // <<< END    _WalletTopUpState.build()
}
// <<< END    class _WalletTopUpState
