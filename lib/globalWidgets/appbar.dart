import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class Appbar extends StatelessWidget {
const Appbar({
   Key? key, 
   this.screenTitle, 
   this.textcolor,
   this.bgcolor,
   this.prefixicon,



}) : super(key: key);
  final String? screenTitle;
  final textcolor;
  final bgcolor;
  final prefixicon;


  @override
  Widget build(BuildContext context){
    return Scaffold (
      appBar: AppBar(
        title: Text(screenTitle!,
        style: TextStyle(
            color: tBlue,
            fontWeight: FontWeight.w600,
            fontSize: isTab(context) ? 12.sp : 10.sp
            ),
    
         ),
         backgroundColor: bgcolor,
        leading: prefixicon,
        

      ),
    );
  }
}
