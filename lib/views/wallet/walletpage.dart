// ----------------------------------------------------------------------
// Wallet
//
// Wallet screen: balance, add money, withdraw and transactions.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/wallet/components.dart';
import 'package:base_project_flutter/views/wallet/transactiondetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../globalFuctions/globalFunctions.dart';
import '../../responsive.dart';

// >>> START  class WalletPage
class WalletPage extends StatefulWidget {
  const WalletPage({Key? key, this.selectedType}) : super(key: key);

  final selectedType;
  State<WalletPage> createState() => _WalletPageState();
}
// <<< END    class WalletPage

// >>> START  class _WalletPageState
class _WalletPageState extends State<WalletPage> {
  // >>> START  _WalletPageState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: tYellow,
        title: Text(
          'Wallet',
          style: GoogleFonts.mulish(
            color: tBlue,
            fontSize: isTab(context) ? 14.sp : 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              WalletCardWidget(),
              TransactionDetailsWidget(
                selectedType: widget.selectedType,
              )
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tPrimaryColor,
        onPressed: () {
          Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 2));
        },
        child: Icon(
          Icons.refresh,
        ),
      ),
    );
  }
  // <<< END    _WalletPageState.build()
}
// <<< END    class _WalletPageState
