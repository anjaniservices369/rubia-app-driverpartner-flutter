import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../responsive.dart';

class TextFormFieldWidgets extends StatelessWidget {
  const TextFormFieldWidgets({
    Key? key,
    required this.controller,
    this.validator,
    this.hinttext,
    this.label,
    this.border,
    this.hintStyl,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixtxt,
    this.style,
    this.maxLines,
    this.fillcolor,
    this.inputFormater,
    this.keyboardTyp,
    this.contentPadding,
    this.onChanged,
  }) : super(key: key);

  final controller;
  final validator;
  final hinttext;
  final style;
  final border;
  final fillcolor;
  final hintStyl;
  final label;
  final prefixIcon;
  final suffixtxt;
  final suffixIcon;
  final maxLines;
  final inputFormater;
  final keyboardTyp;
  final contentPadding;
  final onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: validator,
        maxLines: maxLines,
        cursorColor: tBlack,
        inputFormatters: inputFormater,
        controller: controller,
        keyboardType: keyboardTyp,
        onChanged: onChanged,
        style: TextStyle(fontSize: isTab(context) ? 9.sp : 12.sp, fontWeight: FontWeight.w600, color: tSecondaryColor),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          label: label,
          suffixIcon: suffixIcon,
          suffixText: suffixtxt,
          hintStyle: TextStyle(fontSize: isTab(context) ? 9.sp : 12.sp, fontWeight: FontWeight.w500, color: tGray),
          hintText: hinttext,
          fillColor: ttextfildfillcolor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tgreen.withOpacity(0.40), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tgreen.withOpacity(0.40), width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tRed, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tRed, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
