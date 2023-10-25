import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../responsive.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({Key? key}) : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  bool switchcondition = true;
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(switchcondition == false ? 'Offline' : 'Online',
              style: GoogleFonts.mulish(
                  color: tBlack,
                  fontWeight: FontWeight.w700,
                  fontSize: isTab(context) ? 9.sp : 12.sp)),
          SizedBox(
            width: 2.w,
          ),
          FlutterSwitch(
              height: isTab(context) ? 3.4.h : 3.h,
              width: isTab(context) ? 10.w : 12.w,
              padding: 3.0,
              toggleSize: 20.0,
              borderRadius: 15.0,
              activeColor: tPrimaryColor,
              inactiveColor: tBackground,
              toggleColor: switchcondition == true ? tWhite : tRed,
              value: switchcondition,
              onToggle: (value) {
                setState(() {
                  switchcondition = value;
                });
              }),
        ],
      ),
    );
  }
}
