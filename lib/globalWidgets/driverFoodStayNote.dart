// ----------------------------------------------------------------------
// Driver food and accommodation note
//
// On an outstation round trip the customer provides the driver's food and
// accommodation; they are not part of the fare. Shown on the ride details and
// the bill, for that trip type only.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/responsive.dart';

// >>> START  class DriverFoodStayNote
class DriverFoodStayNote extends StatelessWidget {
  const DriverFoodStayNote({Key? key, required this.rideDetails}) : super(key: key);
  final rideDetails;

  // >>> START  DriverFoodStayNote.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    final tripType = int.tryParse(rideDetails['trip_type'].toString()) ?? 0;
    final riderType = int.tryParse(rideDetails['rider_type'].toString()) ?? 0;
    if (tripType != TRIP_TYPE_OUTSTATION || riderType != RIDER_TYPE_ROUNDTRIP) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: tlightGray.withOpacity(0.35), borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.restaurant, size: 18, color: tPrimaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "The customer provides your food and accommodation during this trip. They are not included in the fare.",
              style: TextStyle(color: tSecondaryColor, fontSize: isTab(context) ? 8.sp : 10.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
  // <<< END    DriverFoodStayNote.build()
}
// <<< END    class DriverFoodStayNote
