import 'package:dakowa_app/models/supporter.dart';

class Goal {
  String? title;
  String? mode;
  bool? active;
  double? maxAmount;
  double? amountGotten;
  String? note;
  String? creatorUsername;
  String? ref;
  List<Supporter>? supporters;
  String? startDate;
  String? endDate;
  Creator? creator;
  String? createdAt;
  String? updatedAt;
  String? id;

  Goal(
      {this.title,
        this.mode,
        this.active,
        this.maxAmount,
        this.amountGotten,
        this.note,
        this.creatorUsername,
        this.ref,
        this.supporters,
        this.startDate,
        this.endDate,
        this.creator,
        this.createdAt,
        this.updatedAt,
        this.id});

  Goal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    mode = json['mode'];
    active = json['active'];
    maxAmount = json['maxAmount'].toDouble();
    amountGotten = json['amountGotten'].toDouble();
    note = json['note'];
    creatorUsername = json['creatorUsername'];
    ref = json['ref'];
    if (json['supporters'] != null) {
      supporters = [];
      json['supporters'].forEach((v) {
        supporters!.add(new Supporter.fromJson(v));
      });
    }
    startDate = json['startDate'];
    endDate = json['endDate'];
    creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['mode'] = this.mode;
    data['active'] = this.active;
    data['maxAmount'] = this.maxAmount;
    data['amountGotten'] = this.amountGotten;
    data['note'] = this.note;
    data['creatorUsername'] = this.creatorUsername;
    data['ref'] = this.ref;
    if (this.supporters != null) {
      data['supporters'] = this.supporters!.map((v) => v.toJson()).toList();
    }
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

