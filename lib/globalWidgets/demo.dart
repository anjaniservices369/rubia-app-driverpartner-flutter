import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';

import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/homePage/homePage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/constants.dart';
import 'package:sizer/sizer.dart';

 

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  Map<String, String> tiles = {
    Images. BACK: "My courses",
    Images.BACK: "My Quiz",
    Images.BACK: "My Profile",
    Images.BACK: "Notifications",
    Images.BACK: "Visit our website",
    Images.BACK: "About us",
    Images.BACK: "Privacy policy",
    Images.BACK: "Terms and condition",
    Images.BACK: "Contact us",
  };

  // bool _switchValue = false;
  var checkDetails;
  var resNOK;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    List screens = [
      
      BottomNavigation( ),
      BottomNavigation( ),
      BottomNavigation( ),
      BottomNavigation( ),
      BottomNavigation( ),

      //BottomNavigation(tabIndexId: 0),
      // QuitionPa(),

      //BottomNavigation(tabIndexId: 0),
      // Quitiage(),
      // QuitionPage(),
      // BottomNavigation(tabIndexId: 0),
      // BottomNavigation(tabIndexId: 0),
    ];
    return Container(
      // width: isTab(context) ? 50.w : 70.w,
      child: Drawer(
        width: isTab(context) ? 60.w : null,
        elevation: 0.0,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration( color: tPrimaryColor),
              height: 3.h,
            ),
            GestureDetector(
              onTap: () {
                // Twl.forceNavigateTo(context, ProfilePage());
              },
              child:   Container(
                      
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                color: tWhite, shape: BoxShape.circle),
                            child: checkDetails['profile_image'] == null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://media.istockphoto.com/id/518757779/photo/happy-boy-in-leather-jacket-posing-on-the-ground.jpg?b=1&s=170667a&w=0&k=20&c=xxnFEYxgcIjtI9tTpF3Egc7RNd3ztDzo3qae8GEdd74="),
                                    radius: 28.0,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        checkDetails['profile_image']
                                            .toString()),
                                    radius: 28.0,
                                  ),
                          ),
                          // leading: ProfileImage(
                          //   imgUrl:
                          //       "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
                          //   borderColor: tlightGray,
                          // ),
                          title: Text(
                            checkDetails['first_name'].toString() +
                                ' ' +
                                checkDetails['last_name'].toString(),
                            style: GoogleFonts.mulish(
                                color: tWhite,
                                fontWeight: FontWeight.w800,
                                fontSize: isTab(context) ? 12.sp : 14.sp),
                          ))),
            ),
            Expanded(
              child: Column(
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ...List.generate(tiles.length, (index) {
                        return Column(
                          children: [
                            if (isTab(context))
                              SizedBox(height: index == 0 ? 0 : 2.h),
                            DrawerTileWidget(
                              icon: tiles.keys.toList()[index].toString(),
                              title: tiles.values.toList()[index].toString(),
                              onTap: () {
                                // log("message");
                                Twl.navigateTo(context, screens[index]);
                              },
                            ),
                           Text("data")
                          ],
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              decoration: BoxDecoration(
                color: tPrimaryColor.withOpacity(0.1),
              ),
              child: ListTile(
                  contentPadding:
                      EdgeInsets.only(left: isTab(context) ? 2.w : 8.w),
                  leading: Container(
                      padding: isTab(context)
                          ? EdgeInsets.all(12)
                          : EdgeInsets.all(15),
                      decoration: BoxDecoration(
                      
                          shape: BoxShape.circle),
                      child: Image.asset(
                        Images.LOGOUT,
                        scale: isTab(context) ? 2 : 3,
                      )),
                  title: Text(
                    'Log out',
                    style: GoogleFonts.mulish(
                        color: tBlack,
                        fontWeight: FontWeight.w800,
                        fontSize: isTab(context) ? 12.sp : 14.sp),
                  ),
                  onTap: () {
                    // showModalBottomSheet(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.vertical(
                    //             top: Radius.circular(15.0))),
                    //     backgroundColor: tWhite,
                    //     context: context,
                    //     isScrollControlled: true,
                    //     builder: (context) => Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [Logout()],
                    //         ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerTileWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  final String icon;
  DrawerTileWidget({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: isTab(context) ? 2.w : 10.w),
      leading: Image.asset(
        icon,
        scale: isTab(context)
            ? title == "Complaint"
                ? 3.5
                : 2.5
            : title == "Complaint"
                ? 4
                : 3.5,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: tBlack,
            fontSize: isTab(context) ? 7.sp : 12.sp),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}