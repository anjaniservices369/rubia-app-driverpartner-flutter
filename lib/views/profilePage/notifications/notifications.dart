import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../responsive.dart';
import '../../../../globalFuctions/globalFunctions.dart';
import '../../../constants/imageConstant.dart';

import '../../homePage/homePage.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // late Future<NOTIFICATION.NotificationModel> myRides;
  void initState() {
    super.initState();
    // myRides = HomeApi().fetchNotifications(
    //   context,
    //   '0',
    // );
  }

  List<String> name = ['Start Your First Ride with Winter Offers.', 'Hey! '];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          // return Twl.forceNavigateTo(context, HomePage());
          return Twl.navigateBack(context);
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              titleSpacing: 7,
              backgroundColor: tYellow,
              leading: GestureDetector(
                  onTap: () {
                    Twl.navigateBack(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: tBlue,
                      size: 16,
                    ),
                  )),
              title: Text('Notification'.tr,
                  style: GoogleFonts.mulish(
                    color: tBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: isTab(context) ? 14.sp : 16.sp,
                  )),
              actions: [
                PopupMenuButton<int>(
                    // onSelected: (value) async {
                    //   var res = await HomeApi().clearNotifications(context);
                    //   if (res['status'] != null && res['status'] == 'OK') {
                    //     Twl.forceNavigateTo(context, Notifactionpage());
                    //   } else {
                    //     Twl.createAlert(context, 'Oops', res['error'].toString());
                    //   }
                    // },
                    icon: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.more_vert,
                          color: tBlue,
                          // size: isTab(context) ? 20 : 30,
                        )
                        //  Icon(
                        //            isChargesSelected
                        //                 ? Icons.keyboard_arrow_down
                        //                 : Icons.keyboard_arrow_up,
                        //             size: 35,
                        //             color: tGreencolor,
                        //           ),
                      ],
                    ),
                    tooltip: "  ",
                    // icon: Image.asset(Images.),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    offset: Offset(
                      -40,
                      -0,
                    ),
                    color: tWhite,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            height: 0.4.h,
                            child: Text("Clear",
                                style: GoogleFonts.mulish(
                                    color: tPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTab(context) ? 9.sp : 12.sp)),
                            value: 1,
                          ),
                        ]),
              ],
            ),
            body: ListView.builder(
                itemCount: 2,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                // controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  // var notificationDetails = notificationList[index];
                  return GestureDetector(
                    onTap: () {
                      // Twl.forceNavigateTo(context, );
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 0.6.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: tWhite,
                            boxShadow: [tBoxShadow]),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: tPrimaryColor.withOpacity(0.2)),
                                  child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.notifications,
                                        color: tPrimaryColor,
                                      )),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        child: Text(name[index],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.mulish(
                                                color: tBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: isTab(context)
                                                    ? 8.sp
                                                    : 12.sp)),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        child: Text(
                                            'We saw you checking us but not riding with us. Tell us what interested you & what didn’t',
                                            // notificationDetails.description.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.mulish(
                                                color: tLightBrown,
                                                fontWeight: FontWeight.w500,
                                                fontSize: isTab(context)
                                                    ? 7.sp
                                                    : 8.5.sp)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text('2 days',
                                  // notificationDetails.createdDate.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.mulish(
                                      color: tLightBrown,
                                      fontWeight: FontWeight.w500,
                                      fontSize: isTab(context) ? 7.sp : 9.sp)),
                            )
                          ],
                        )),
                  );
                })

            // FutureBuilder<NOTIFICATION.NotificationModel>(
            //     future: myRides,
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState != ConnectionState.done) {
            //         return Container(
            //           child: Align(
            //               alignment: Alignment.center,
            //               child: SpinKitThreeBounce(
            //                 color: tPrimaryColor,
            //                 size: 20.0,
            //               )),
            //         );
            //       }
            //       if (snapshot.hasError) {
            //         print('Error of coupons' + snapshot.error.toString());
            //       }
            //       if (snapshot.hasData) {
            //         return Padding(
            //           padding: EdgeInsets.symmetric(vertical: 10),
            //           child: Container(
            //             child: NotificationPagination(
            //                 notificationData: snapshot.data, status: ''),
            //           ),
            //         );
            //       } else {
            //         return Center(child: Text('No notification found'));
            //       }
            //     })),
            ));
  }
}

// class NotificationPagination extends StatefulWidget {
//   const NotificationPagination({
//     Key? key,
//     this.notificationData,
//     this.status,
//   }) : super(key: key);
//   final notificationData;
//   final status;

//   @override
//   State<NotificationPagination> createState() => _NotificationPaginationState();
// }

// class _NotificationPaginationState extends State<NotificationPagination> {
//   ScrollController scrollController = new ScrollController();
//   int page = 0;
//   late List<NOTIFICATION.Detail> notificationList;
//   late double scrollPosition;
//   var listText;
//   _scrollListener() {
//     if (scrollController.position.maxScrollExtent > scrollController.offset &&
//         scrollController.position.maxScrollExtent - scrollController.offset <=
//             95) {
//       print('End Scroll');
//       page = (page + 1);
//       HomeApi().fetchNotifications(context, page.toString()).then((val) {
//         // currentPage = currentPage++;
//         if (val.details != null) {
//           setState(() {
//             // currentPage = currentPage + 1;
//             notificationList.addAll(val.details);
//           });
//         } else {
//           return Center(
//             child: Text('End of data'),
//           );
//         }
//       });
//     }
//   }

//   void initState() {
//     scrollController = ScrollController();
//     notificationList = widget.notificationData.details;
//     scrollController.addListener(_scrollListener);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: notificationList.length,
//         physics: ScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         controller: scrollController,
//         itemBuilder: (BuildContext context, int index) {
//           var notificationDetails = notificationList[index];
//           return Container(
//               margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.6.h),
//               padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: tWhite,
//                   boxShadow: [tBoxShadow]),
//               child: Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle, color: tPrimaryColor),
//                         child: Padding(
//                           padding: EdgeInsets.all(5.0),
//                           child: Image.asset(
//                             Images.CAR,
//                             color: tBlack,
//                             scale: isTab(context) ? 2.5 : 3.5,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 3.w,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width / 1,
//                               child: Text(notificationDetails.title.toString(),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: GoogleFonts.mulish(
//                                       color: tBlack,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: isTab(context) ? 8.sp : 12.sp)),
//                             ),
//                             SizedBox(
//                               height: 0.5.h,
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width / 1,
//                               child: Text(
//                                   notificationDetails.description.toString(),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: GoogleFonts.mulish(
//                                       color: tBlack,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize:
//                                           isTab(context) ? 7.sp : 8.5.sp)),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 1.5.h,
//                   ),
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(notificationDetails.createdDate.toString(),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: GoogleFonts.mulish(
//                             color: tGray,
//                             fontWeight: FontWeight.w500,
//                             fontSize: isTab(context) ? 7.sp : 9.sp)),
//                   )
//                 ],
//               ));
//         });
//   }
// }
