// ----------------------------------------------------------------------
// Back button
//
// The round back arrow shown at the top-left of screens.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';
import '../constants/constants.dart';

// >>> START  class BackButtonLeading
class BackButtonLeading extends StatelessWidget {
  const BackButtonLeading({
    Key? key,
  
    this.onTap,
  }) : super(key: key);

 
  final onTap;
  // >>> START  BackButtonLeading.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap:  onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                  decoration: BoxDecoration(
                      color: tWhite,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ]),
                  child: Center(
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color:  tPrimaryColor,
                      size: 30,
                    ),
                  )),
            ),
          );
  }
  // <<< END    BackButtonLeading.build()
}
// <<< END    class BackButtonLeading
