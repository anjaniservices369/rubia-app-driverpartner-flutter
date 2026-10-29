// ----------------------------------------------------------------------
// Withdraw money from the wallet
//
// Shows the bank account the driver registered (the money is always paid to that account), the
// balance and the minimum, and lets the driver request a withdrawal. The office pays it and marks
// it paid in the dashboard.
//
// Developer note: driver/withdraw-info (balance, min_withdraw, bank masked, pending requests) and
// driver/withdraw (amount). A driver without bank details is sent to the Bank Details screen.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../api_services/rideBookingsApi.dart';
import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../responsive.dart';
import '../bottomNavigation.dart/bottomNavigation.dart';
import '../rider_Details/componants/bank_details.dart';

// >>> START  showWalletWithdraw()  -  show wallet withdraw
/// Opens the withdraw sheet from the wallet screen.
void showWalletWithdraw(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: tWhite,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => const WalletWithdraw(),
  );
}
// <<< END    showWalletWithdraw()

// >>> START  class WalletWithdraw
class WalletWithdraw extends StatefulWidget {
  const WalletWithdraw({Key? key}) : super(key: key);

  @override
  State<WalletWithdraw> createState() => _WalletWithdrawState();
}
// <<< END    class WalletWithdraw

// >>> START  class _WalletWithdrawState
class _WalletWithdrawState extends State<WalletWithdraw> {
  final TextEditingController _amount = TextEditingController();
  Map<String, dynamic>? _info;
  String? _loadError;
  bool _busy = false;

  // >>> START  _WalletWithdrawState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
    _load();
  }
  // <<< END    _WalletWithdrawState.initState()

  // >>> START  _WalletWithdrawState.dispose()  -  cleanup when the screen closes
  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }
  // <<< END    _WalletWithdrawState.dispose()

  // >>> START  _WalletWithdrawState._load()
  Future<void> _load() async {
    final res = await RideBookingsApi().getWithdrawInfo(context);
    if (!mounted) return;
    setState(() {
      if (res != null && res['status'] == 'OK') {
        _info = Map<String, dynamic>.from(res['details']);
        _loadError = null;
      } else {
        _loadError = '${res?['error'] ?? 'Could not load your wallet. Please try again.'}';
      }
    });
  }
  // <<< END    _WalletWithdrawState._load()

  // >>> START  _WalletWithdrawState._request()
  Future<void> _request() async {
    final info = _info!;
    final a = int.tryParse(_amount.text.trim());
    final balance = (info['balance'] as num).toInt();
    final min = (info['min_withdraw'] as num).toInt();
    if (a == null || a < 1) {
      Twl.createAlert(context, 'Oops', 'Enter a whole number of rupees.');
      return;
    }
    if (min > 0 && a < min) {
      Twl.createAlert(context, 'Oops', 'The minimum withdrawal is ₹$min.');
      return;
    }
    if (a > balance) {
      Twl.createAlert(context, 'Oops', 'You can withdraw up to ₹$balance.');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _busy = true);
    final res = await RideBookingsApi().withdrawAmount(context, {'amount': '$a'});
    if (!mounted) return;
    setState(() => _busy = false);
    if (res != null && res['status'] == 'OK') {
      Navigator.of(context).pop();
      await Twl.createAlert(context, 'Request sent',
          '₹$a will be paid to your bank account (${info['bank']['bank_name']}, ${info['bank']['account_number_masked']}). The office will transfer it and it then shows as paid.');
      Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 2));
    } else {
      Twl.createAlert(context, 'Oops', '${res?['error'] ?? 'Could not send the request. Please try again.'}');
    }
  }
  // <<< END    _WalletWithdrawState._request()

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 30.w, child: Text(label, style: TextStyle(color: tbrown, fontSize: isTab(context) ? 9.sp : 11.sp))),
          Expanded(child: Text(value, style: TextStyle(color: tSecondaryColor, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 9.sp : 11.sp))),
        ]),
      );

  // >>> START  _WalletWithdrawState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    final info = _info;
    final bank = info == null ? null : info['bank'] as Map?;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Withdraw'.tr,
                  style: GoogleFonts.mulish(fontSize: isTab(context) ? 12.sp : 16.sp, fontWeight: FontWeight.w800, color: tSecondaryColor)),
              SizedBox(height: 2.h),
              if (_loadError != null) ...[
                Text(_loadError!, style: const TextStyle(color: Colors.red)),
                TextButton(onPressed: _load, child: Text('Retry', style: TextStyle(color: tPrimaryColor))),
              ] else if (info == null)
                const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
              else ...[
                Text('Available balance: ₹${(info['balance'] as num).toInt()}',
                    style: GoogleFonts.mulish(fontSize: isTab(context) ? 11.sp : 14.sp, fontWeight: FontWeight.w800, color: tPrimaryColor)),
                SizedBox(height: 2.h),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: tBackground, borderRadius: BorderRadius.circular(12)),
                  child: bank == null
                      ? Text('You have not added bank details yet. Withdrawals are paid to your bank account, so add it first.',
                          style: TextStyle(color: tSecondaryColor, fontSize: isTab(context) ? 9.sp : 11.sp))
                      : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Paid to this account', style: TextStyle(color: tbrown, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 9.sp : 11.sp)),
                          const SizedBox(height: 6),
                          _row('Name', '${bank['account_holder_name']}'),
                          _row('Bank', '${bank['bank_name']}'),
                          _row('Account', '${bank['account_number_masked']}'),
                          _row('IFSC', '${bank['ifsc']}'),
                          if ('${bank['upi']}'.isNotEmpty) _row('UPI', '${bank['upi']}'),
                        ]),
                ),
                SizedBox(height: 1.h),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: tWhite, builder: (_) => BankDetails());
                  },
                  child: Text(bank == null ? 'Add bank details' : 'Change bank details', style: TextStyle(color: tPrimaryColor, fontWeight: FontWeight.w700)),
                ),
                if (bank != null) ...[
                  SizedBox(height: 1.h),
                  TextField(
                    controller: _amount,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(7)],
                    style: TextStyle(fontWeight: FontWeight.w700, color: tSecondaryColor, fontSize: 18),
                    decoration: InputDecoration(
                      prefixText: '₹ ',
                      hintText: 'enter_amount'.tr + ((info['min_withdraw'] as num) > 0 ? ' (min ₹${(info['min_withdraw'] as num).toInt()})' : ''),
                      filled: true,
                      fillColor: tBackground,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  if ((info['pending'] as List).isNotEmpty) ...[
                    SizedBox(height: 1.h),
                    Text('Waiting for the office to pay: ${(info['pending'] as List).map((p) => '₹${p['amount']}').join(', ')}',
                        style: TextStyle(color: tbrown, fontSize: isTab(context) ? 9.sp : 11.sp)),
                  ],
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: double.infinity,
                    height: 6.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: tPrimaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: _busy ? null : _request,
                      child: _busy
                          ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                          : Text('Request withdrawal', style: GoogleFonts.mulish(color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 13.sp)),
                    ),
                  ),
                ],
              ],
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
    );
  }
  // <<< END    _WalletWithdrawState.build()
}
// <<< END    class _WalletWithdrawState
