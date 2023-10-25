// To parse this JSON data, do
//
//     final transactionListModel = transactionListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TransactionListModel transactionListModelFromJson(String str) =>
    TransactionListModel.fromJson(json.decode(str));

String transactionListModelToJson(TransactionListModel data) =>
    json.encode(data.toJson());

class TransactionListModel {
  String status;
  String url;
  List<Detail> details;

  TransactionListModel({
    required this.status,
    required this.url,
    required this.details,
  });

  factory TransactionListModel.fromJson(Map<String, dynamic> json) =>
      TransactionListModel(
        status: json["status"],
        url: json["url"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "url": url,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  dynamic id;
  dynamic driverId;
  dynamic amount;
  dynamic paymentType;
  dynamic methodReason;
  dynamic status;
  dynamic createdOn;
  dynamic updatedOn;
  dynamic createUserId;
  dynamic updateUserId;

  Detail({
    required this.id,
    required this.driverId,
    required this.amount,
    required this.paymentType,
    required this.methodReason,
    required this.status,
    required this.createdOn,
    required this.updatedOn,
    required this.createUserId,
    required this.updateUserId,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        driverId: json["driver_id"],
        amount: json["amount"],
        paymentType: json["payment_type"],
        methodReason: json["method_reason"],
        status: json["status"],
        createdOn: DateTime.parse(json["created_on"]),
        updatedOn: DateTime.parse(json["updated_on"]),
        createUserId: json["create_user_id"],
        updateUserId: json["update_user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driver_id": driverId,
        "amount": amount,
        "payment_type": paymentType,
        "method_reason": methodReason,
        "status": status,
        "created_on": createdOn.toIso8601String(),
        "updated_on": updatedOn.toIso8601String(),
        "create_user_id": createUserId,
        "update_user_id": updateUserId,
      };
}
