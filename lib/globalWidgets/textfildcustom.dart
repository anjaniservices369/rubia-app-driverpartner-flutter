// ----------------------------------------------------------------------
// Text input (style B)
//
// Second variant of the styled text box for forms.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';
import '../constants/constants.dart';

// >>> START  class TextFieldWidgets
class TextFieldWidgets extends StatelessWidget {
  const TextFieldWidgets({
    Key? key,
    required this.controller,
    this.validator,
    this.onChanged,
    this.hinttext,
    this.label,
    this.border,
    this.hintStyl,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.suffixtxt,
    this.style,
    this.maxLines,
    this.onTap,
    this.fillcolor,
    this.inputFormatters,
    this.readOnly,
    this.textCapitalization,
    this.contentPadding,
  }) : super(key: key);

  final controller;
  final validator;
  final hinttext;
  final textCapitalization;
  final style;
  final border;
  final fillcolor;
  final onChanged;
  final hintStyl;
  final keyboardType;
  final label;
  final prefixIcon;
  final suffixtxt;
  final suffixIcon;
  final onTap;
  final readOnly;
  final maxLines;
  final inputFormatters;

  final contentPadding;
  // >>> START  TextFieldWidgets.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        style: TextStyle(
          color: tSecondaryColor,
          fontWeight: FontWeight.w600,
        ),
        controller: controller,
        // controller: widget.firstName == null
        //     ? _firstNameController
        //     : _firstNameController
        //   ..text = widget.firstName,
        textCapitalization: textCapitalization == null
            ? TextCapitalization.none
            : textCapitalization,
        validator: validator,

        onChanged: onChanged,

        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          filled: true,
          fillColor: tlightGray.withValues(alpha: 0.4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: tgreen, width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: tgreen, width: 1),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: tgreen, width: 1),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: tgreen, width: 1),
              borderRadius: BorderRadius.circular(10)),
          hintText: hinttext,
          hintStyle: hintStyl,
        ),
      ),
    );
  }
  // <<< END    TextFieldWidgets.build()
}
// <<< END    class TextFieldWidgets
