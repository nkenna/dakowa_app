import 'package:dakowa_app/models/post.dart';
import 'package:dakowa_app/models/supporter.dart';

class User {
  String? name;
  String? email;
  String? username;
  String? headerImage;
  String? avatar;
  double? karfa;
  String? videoUrl;
  bool? status;
  String? firstAttribute;
  String? secondAttribute;
  bool? verified;
  String? type;
  String? pocketRef;
  List<Supporter>? supporters;
  List<User>? followers;
  List<User>? following;
  List<Post>? posts;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  Pocket? pocket;
  String? id;
  BankInfo? bankinfo;

  User(
      {this.name,
        this.email,
        this.username,
        this.headerImage,
        this.bankinfo,
        this.avatar,
        this.karfa,
        this.videoUrl,
        this.status,
        this.firstAttribute,
        this.secondAttribute,
        this.verified,
        this.type,
        this.pocketRef,
        this.supporters,
        this.followers,
        this.following,
        this.posts,
        this.comments,
        this.createdAt,
        this.updatedAt,
        this.pocket,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    headerImage = json['headerImage'];
    avatar = json['avatar'];
    karfa = json['karfa'] != null ? json['karfa'].toDouble() : 0.0;
    videoUrl = json['videoUrl'];
    status = json['status'];
    firstAttribute = json['firstAttribute'];
    secondAttribute = json['secondAttribute'];
    verified = json['verified'];
    type = json['type'];
    pocketRef = json['pocketRef'];
    if (json['supporters'] != null) {
      supporters = [];
      json['supporters'].forEach((v) {
        if(v.runtimeType == String){
          supporters!.add(new Supporter(id: v));
        }else{
          supporters!.add(new Supporter.fromJson(v));
        }
      });
    }
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        if(v.runtimeType == String){
          followers!.add(new User(id: v));
        }else{
          followers!.add(new User.fromJson(v));
        }
      });
    }
    if (json['following'] != null) {
      following = [];
      json['following'].forEach((v) {
        if(v.runtimeType == String){
          following!.add(new User(id: v));
        }else{
          following!.add(new User.fromJson(v));
        }
      });
    }
    if (json['posts'] != null) {

      if(json['posts'].runtimeType == String){
        posts = json['posts'].cast<String>();
      }else{
        posts = [];
        json['posts'].forEach((v) {
          if(v.runtimeType == String){
            posts!.add(Post(id: v));
          }else{
            posts!.add(new Post.fromJson(v));
          }
        });
      }

    }
    if (json['comments'] != null) {
      if(json['comments'].runtimeType == String){
        comments = json['comments'].cast<String>();
      }else{
        comments = [];
        json['comments'].forEach((v) {
          if(v.runtimeType == String){
            comments!.add(Comments(sId: v));
          }else{
            comments!.add(new Comments.fromJson(v));
          }
        });
      }

    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if(json['pocket'] != null){
      if(json['pocket'].runtimeType == String){
        pocket = Pocket(sId: json['pocket']);
      }else{
        pocket = json['pocket'] != null ? new Pocket.fromJson(json['pocket']) : null;
      }
    }
    if(json['bankinfo'] != null){
      if(json['bankinfo'].runtimeType == String){
        bankinfo = BankInfo(sId: json['bankinfo']);
      }else{
        bankinfo = json['bankinfo'] != null ? new BankInfo.fromJson(json['bankinfo']) : null;
      }
    }
    //pocket = json['pocket'] != null ? new Pocket.fromJson(json['pocket']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['headerImage'] = this.headerImage;
    data['avatar'] = this.avatar;
    data['karfa'] = this.karfa;
    data['videoUrl'] = this.videoUrl;
    data['status'] = this.status;

    data['firstAttribute'] = this.firstAttribute;
    data['secondAttribute'] = this.secondAttribute;
    data['verified'] = this.verified;
    data['type'] = this.type;
    data['pocketRef'] = this.pocketRef;
    if (this.supporters != null) {
      data['supporters'] = this.supporters!.map((v) => v.toJson()).toList();
    }
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    if (this.following != null) {
      data['following'] = this.following!.map((v) => v.toJson()).toList();
    }
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.pocket != null) {
      data['pocket'] = this.pocket!.toJson();
    }
    if (this.bankinfo != null) {
      data['bankinfo'] = this.bankinfo!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class BankInfo {
  String? bankName;
  String? accountName;
  String? accountNumber;
  String? bankCode;
  String? creatorUsername;
  String? currency;
  String? recipientCode;
  String? type;
  String? name;
  String? description;
  String? sId;
  bool? active;
  int? recipientId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BankInfo(
      {this.bankName,
        this.accountName,
        this.accountNumber,
        this.bankCode,
        this.creatorUsername,
        this.currency,
        this.recipientCode,
        this.type,
        this.name,
        this.description,
        this.sId,
        this.active,
        this.recipientId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  BankInfo.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
    bankCode = json['bankCode'];
    creatorUsername = json['creatorUsername'];
    currency = json['currency'];
    recipientCode = json['recipient_code'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    sId = json['_id'];
    active = json['active'];
    recipientId = json['recipient_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    data['accountName'] = this.accountName;
    data['accountNumber'] = this.accountNumber;
    data['bankCode'] = this.bankCode;
    data['creatorUsername'] = this.creatorUsername;
    data['currency'] = this.currency;
    data['recipient_code'] = this.recipientCode;
    data['type'] = this.type;
    data['name'] = this.name;
    data['description'] = this.description;
    data['_id'] = this.sId;
    data['active'] = this.active;
    data['recipient_id'] = this.recipientId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}


class Pocket {
  String? pocketRef;
  double? balance;
  String? username;
  String? sId;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Pocket(
      {this.pocketRef,
        this.balance,
        this.username,
        this.sId,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Pocket.fromJson(Map<String, dynamic> json) {
    pocketRef = json['pocketRef'];
    balance = json['balance'] != null ? json['balance'].toDouble() : 0.0;
    username = json['username'];
    sId = json['_id'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pocketRef'] = this.pocketRef;
    data['balance'] = this.balance;
    data['username'] = this.username;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}