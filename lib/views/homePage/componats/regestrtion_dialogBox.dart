// import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
// import '../../../constants/constants.dart';
// import '../../../globalWidgets/button.dart';
// import '../../../responsive.dart';
// import '../../bottomNavigation.dart/bottomNavigation.dart';

// class RegisucceDialogBox extends StatefulWidget {
//   const RegisucceDialogBox({Key? key}) : super(key: key);

//   @override
//   State<RegisucceDialogBox> createState() => _RegisucceDialogBoxState();
// }

// class _RegisucceDialogBoxState extends State<RegisucceDialogBox> {
//   @override
//   int reason = 0;

//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: tWhite,
//       insetPadding: EdgeInsets.symmetric(horizontal: 40),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Container(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 4.h,
//               ),
//               Center(
//                 child: Text(
//                   "Please pay the amount",
//                   style: GoogleFonts.mulish(
//                     color: tSecondaryColor,
//                     fontWeight: FontWeight.w800,
//                     fontSize: isTab(context) ? 12.sp : 14.sp,
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   "before continuing",
//                   style: GoogleFonts.mulish(
//                     color: tSecondaryColor,
//                     fontWeight: FontWeight.w800,
//                     fontSize: isTab(context) ? 12.sp : 14.sp,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 2.h,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(
               
//                   horizontal: 35, vertical: 10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: tLightOrenge),
//                 child: Text(
//                   "₹310",
//                   style: GoogleFonts.mulish(
//                     color: tSecondaryColor,
//                     fontWeight: FontWeight.w800,
//                     fontSize: isTab(context) ? 15.sp : 18.sp,
//                   ),
//                 ),
//               ),
              
//               TextButton(onPressed:  (){}, child:  Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment:  MainAxisAlignment.center,
//                 children: [
//                   Text("Payout Details",  style: GoogleFonts.mulish(
//                     color:  tgreen,
//                     fontWeight: FontWeight.w500,
//                     fontSize: isTab(context) ? 9.sp : 11.sp,
//                   ),),
//                   Icon(Icons. arrow_forward_ios_rounded,
//                 size: 15,
//                   color:   tgreen, )
//                 ],
//               )),
//             SizedBox(
//                 height:1.h,
//               ),
//               SizedBox(
//                 width: 38.w,
//                 child: Button(
//                   color: tPrimaryColor,
//                   textcolor:  tWhite,
//                   bottonText: 'Pay Now'.tr,
//                   borderSide: BorderSide(
//                     color: tPrimaryColor,
//                   ),
//                   onTap: (startLoading, stopLoading, btnState) async {
//                     startLoading();
//                     setState(() {
//                       reason==0;
//                       Twl.navigateBack(context);
//                     });
//                   },
//                 ),
//               ),
              
//               Center(
//                   child: TextButton(
//                 onPressed: (() {
//                   Twl.forceNavigateTo(context,  BottomNavigation(tabIndexId: 1,));

              
//                 }),
//                 child: Text(
//                   "Skip",
//                   style: GoogleFonts.mulish(
//                     color: tPrimaryColor,
//                     fontWeight: FontWeight.w800,
//                     fontSize: isTab(context) ? 10.sp : 12.sp,
//                   ),
//                 ),
//               )),
//               SizedBox(
//                 height: 2.h,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
