class Supporter {
  String? ref;
  String? email;
  String? name;
  int? quantity;
  double? amount;
  String? avatar;
  String? creatorUsername;
  String? goalRef;
  List<Supports>? supports;
  Creator? creator;
  String? createdAt;
  String? updatedAt;
  String? id;

  Supporter(
      {this.ref,
        this.email,
        this.name,
        this.quantity,
        this.amount,
        this.avatar,
        this.creatorUsername,
        this.goalRef,
        this.supports,
        this.creator,
        this.createdAt,
        this.updatedAt,
        this.id});

  Supporter.fromJson(Map<String, dynamic> json) {
    ref = json['ref'];
    email = json['email'];
    name = json['name'];
    quantity = json['quantity'];
    amount = json['amount'].toDouble();
    avatar = json['avatar'];
    creatorUsername = json['creatorUsername'];
    goalRef = json['goalRef'];
    if (json['supports'] != null) {
      supports = [];
      json['supports'].forEach((v) {
        if(v.runtimeType == String){
          supports!.add(new Supports(sId: v));
        }else{
          supports!.add(new Supports.fromJson(v));
        }
      });
    }

    if(json['creator'] != null){
      if(json['creator'].runtimeType == String){
        creator = Creator(sId: json['creator']);
      }else{
        creator = json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
      }
    }

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ref'] = this.ref;
    data['email'] = this.email;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['avatar'] = this.avatar;
    data['creatorUsername'] = this.creatorUsername;
    data['goalRef'] = this.goalRef;
    if (this.supports != null) {
      data['supports'] = this.supports!.map((v) => v.toJson()).toList();
    }
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Supports {
  String? note;
  String? sId;

  Supports({this.note, this.sId});

  Supports.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['_id'] = this.sId;
    return data;
  }
}

class Creator {
  String? name;
  String? username;
  String? headerImage;
  String? avatar;
  String? sId;

  Creator({this.name, this.username, this.headerImage, this.avatar, this.sId});

  Creator.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    headerImage = json['headerImage'];
    avatar = json['avatar'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['headerImage'] = this.headerImage;
    data['avatar'] = this.avatar;
    data['_id'] = this.sId;
    return data;
  }
}