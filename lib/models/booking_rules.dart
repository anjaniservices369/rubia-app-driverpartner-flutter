// >>> START  collectibleBookingFare()  -  collectible booking fare
num collectibleBookingFare(Map<String, dynamic> booking) {
  final price = booking['price_detail'];
  if (price is! Map) {
    throw const FormatException('The booking fare breakdown is missing.');
  }
  final fare = num.tryParse(price['estimatePrice'].toString());
  final pending = num.tryParse((booking['Pending_cancellation_charges'] ?? 0).toString());
  if (fare == null || !fare.isFinite || fare < 0 ||
      pending == null || !pending.isFinite || pending < 0) {
    throw const FormatException('The booking fare is invalid.');
  }
  return fare + pending;
}
// <<< END    collectibleBookingFare()

// >>> START  requiresJoiningFee()  -  requires joining fee
bool requiresJoiningFee(Map<String, dynamic> detail) {
  if (detail['is_paid_joining_fee'] == true) return false;
  final amount = detail['joining_fee_amount'];
  if (amount == null) return true;
  final fee = num.tryParse(amount.toString());
  if (fee == null || !fee.isFinite || fee < 0) {
    throw const FormatException('The joining fee is invalid.');
  }
  return fee > 0;
}
// <<< END    requiresJoiningFee()
