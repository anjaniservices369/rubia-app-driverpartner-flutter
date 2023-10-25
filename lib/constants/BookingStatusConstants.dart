import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';

class StatusConstants {
  getBookingStatusConstants(int status) {
    switch (status) {
      case STATUS_WAITING_FOR_DRIVER:
        return 'Pending';
      case STATUS_DRIVER_ACCEPTED:
        return 'Accepted';
      case STATUS_DRIVER_REJECTED:
        return 'Rejected';
      case STATUS_GO_FOR_PICKUP:
        return 'Way to pickup';
      case STATUS_ARRIVED_LOCATION:
        return 'Reached Location';
      case STATUS_START_RIDE:
        return 'Ride Started';
      case STATUS_RIDE_COMPLETED:
        return 'Ride Completed';
      case STATUS_USER_CANCELLED:
        return 'User Cancelled';
      case STATUS_BOOKING_AUTO_CANCELLED:
        return 'Booking Auto Cancelled';
      case STATUS_DRIVER_CANCELLED:
        return 'Driver Cancelled';
      default:
        return 'pending';
    }
  }

  getBookingStatusConstantsColors(int status) {
    switch (status) {
      case STATUS_WAITING_FOR_DRIVER:
        return tAppbarColor;
      case STATUS_DRIVER_ACCEPTED:
        return tLightGreen;
      case STATUS_DRIVER_REJECTED:
        return tRed;
      case STATUS_GO_FOR_PICKUP:
        return tYellow;
      case STATUS_ARRIVED_LOCATION:
        return tBrown;
      case STATUS_START_RIDE:
        return tSecondaryColor;
      case STATUS_RIDE_COMPLETED:
        return tLightGreen;
      case STATUS_USER_CANCELLED:
        return tRed;
      case STATUS_BOOKING_AUTO_CANCELLED:
        return tRed;
      case STATUS_DRIVER_CANCELLED:
        return tRed;
      default:
        return tAppbarColor;
    }
  }
}
