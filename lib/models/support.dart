import 'package:dakowa_app/models/supporter.dart';

class Support {
  String? ref;
  String? paymentRef;
  String? supporterEmail;
  bool? anonymous;
  double? finalAmount;
  double? amount;
  int? quantity;
  String? supportType;
  double? charges;
  String? note;
  String? name;
  String? status;
  String? creatorUsername;
  Creator? creator;
  String? createdAt;
  String? updatedAt;
  Supporter? supporter;
  String? id;

  Support(
      {this.ref,
        this.paymentRef,
        this.supporterEmail,
        this.anonymous,
        this.finalAmount,
        this.amount,
        this.quantity,
        this.supportType,
        this.charges,
        this.note,
        this.name,
        this.status,
        this.creatorUsername,
        this.creator,
        this.createdAt,
        this.updatedAt,
        this.supporter,
        this.id});

  Support.fromJson(Map<String, dynamic> json) {
    ref = json['ref'];
    paymentRef = json['paymentRef'];
    supporterEmail = json['supporterEmail'];
    anonymous = json['anonymous'];
    finalAmount = json['finalAmount'].toDouble();
    amount = json['amount'].toDouble();
    quantity = json['quantity'];
    supportType = json['supportType'];
    charges = json['charges'].toDouble();
    note = json['note'];
    name = json['name'];
    status = json['status'];
    creatorUsername = json['creatorUsername'];
    creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    supporter = json['supporter'] != null
        ? new Supporter.fromJson(json['supporter'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ref'] = this.ref;
    data['paymentRef'] = this.paymentRef;
    data['supporterEmail'] = this.supporterEmail;
    data['anonymous'] = this.anonymous;
    data['finalAmount'] = this.finalAmount;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['supportType'] = this.supportType;
    data['charges'] = this.charges;
    data['note'] = this.note;
    data['name'] = this.name;
    data['status'] = this.status;
    data['creatorUsername'] = this.creatorUsername;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.supporter != null) {
      data['supporter'] = this.supporter!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}
