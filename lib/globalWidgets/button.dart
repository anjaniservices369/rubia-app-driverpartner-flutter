import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import '../responsive.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.color,
    this.bottonText,
    this.onTap,
    this.borderSide,
    this.textcolor,
    this.loadingColor,
  }) : super(key: key);
  final color;
  final String? bottonText;
  final onTap;
  final borderSide;
  final textcolor;
  final loadingColor;

  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: isTab(context) ? 70 : 55,
      width: 55.w,
      color: color == null ? tPrimaryColor : color,
      borderRadius: 13,
      borderSide:
          borderSide == null ? BorderSide(color: tPrimaryColor) : borderSide,
      child: Text(
        bottonText!,
        style: TextStyle(
            color: textcolor,
            fontWeight: FontWeight.w600,
            fontSize: isTab(context) ? 10.sp : 14.sp),
      ),
      loader: Container(
        padding: EdgeInsets.all(20),
        child: SpinKitRotatingCircle(
          color: Colors.white,
          // size: loaderWidth ,
        ),
      ),
      onTap: onTap,
    );
  }
}

class PopupButton extends StatelessWidget {
  const PopupButton({
    Key? key,
    this.color,
    this.bottonText,
    this.onTap,
    this.borderSide,
    this.textcolor,
  }) : super(key: key);
  final color;
  final String? bottonText;
  final onTap;
  final borderSide;
  final textcolor;

  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: 25,
      width: 65,
      // height: isTab(context) ? 70 : 50,
      // width: 100.w,
      // border: Border.all(width: 1, color: tPrimaryColor),
      // borderRadius: BorderRadius.circular(6)),
      color: color,
      borderRadius: 6,
      borderSide: borderSide,
      elevation: 0,
      child: Text(
        bottonText!,
        style: TextStyle(color: textcolor!),
      ),
      loader: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: SpinKitRotatingCircle(
          color: tPrimaryColor,
          // size: loaderWidth ,
        ),
      ),
      onTap: onTap,
    );
  }
}

class LeadingBackButton extends StatelessWidget {
  const LeadingBackButton({Key? key, this.onPressed}) : super(key: key);
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Image.asset(
          Images.BACK,
          // height: 20,
          scale: 4,
          // color: tBlack2,
        ),
        // iconSize: 20,
        onPressed: onPressed);
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.color,
    this.bottonText,
    this.onTap,
    this.borderSide,
    this.textcolor,
    this.child,
    this.borderRadius,
  }) : super(key: key);
  final color;
  final String? bottonText;
  final onTap;
  final child;
  final borderRadius;
  final borderSide;
  final textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ArgonButton(
        height: isTab(context) ? 70 : 35,
        width: 100.w,
        color: color,
        borderRadius: borderRadius,
        borderSide: borderSide,
        child: child,
        onTap: onTap,
        //  Text(
        //   bottonText!,

        //   style: TextStyle(
        //      letterSpacing: 1,
        //       color: textcolor,
        //       fontWeight: FontWeight.w700,
        //       fontSize: isTab(context) ? 10.sp : 14.sp),
        // ),
        loader: Container(
          padding: EdgeInsets.all(10),
          child: SpinKitRotatingCircle(
            color: Colors.white,
            // size: loaderWidth ,
          ),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    this.color,
    this.bottonText,
    this.onTap,
    this.borderSide,
    this.textcolor,
    this.loadingColor,
  }) : super(key: key);
  final color;
  final String? bottonText;
  final onTap;
  final borderSide;
  final textcolor;
  final loadingColor;

  @override
  Widget build(BuildContext context) {
    return ArgonButton(
      height: isTab(context) ? 70 : 55,
      width: 55.w,
      color: color == null ? tPrimaryColor : color,
      borderRadius: 13,
      borderSide:
          borderSide == null ? BorderSide(color: tPrimaryColor) : borderSide,
      child: Text(
        bottonText!,
        style: TextStyle(
            color: textcolor,
            fontWeight: FontWeight.w600,
            fontSize: isTab(context) ? 10.sp : 10.sp),
      ),
      loader: Container(
        padding: EdgeInsets.all(20),
        child: SpinKitRotatingCircle(
          color: Colors.white,
          // size: loaderWidth ,
        ),
      ),
      onTap: onTap,
    );
  }
}
