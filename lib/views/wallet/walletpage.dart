import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/wallet/components.dart';
import 'package:base_project_flutter/views/wallet/transactiondetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../globalFuctions/globalFunctions.dart';
import '../../responsive.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key, this.selectedType}) : super(key: key);

  @override
  final selectedType;
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
      body: WillPopScope(
        onWillPop: (){
          return Twl.navigateTo(context, BottomNavigation(tabIndexId: 0,));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              WalletCardWidget(),
              TransactionDetailsWidget(
                selectedType: widget.selectedType,
              )
            ],
          ),
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
}
