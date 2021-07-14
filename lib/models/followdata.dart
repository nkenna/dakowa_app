import 'package:dakowa_app/models/post.dart';

class FollowData {
  bool? status;
  Follower? follower;
  Following? following;
  String? createdAt;
  String? updatedAt;
  String? id;

  FollowData(
      {this.status,
        this.follower,
        this.following,
        this.createdAt,
        this.updatedAt,
        this.id});

  FollowData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    follower = json['follower'] != null
        ? new Follower.fromJson(json['follower'])
        : null;
    following = json['following'] != null
        ? new Following.fromJson(json['following'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.follower != null) {
      data['follower'] = this.follower!.toJson();
    }
    if (this.following != null) {
      data['following'] = this.following!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Follower {
  String? name;
  String? email;
  String? username;
  String? headerImage;
  String? avatar;
  String? videoUrl;
  bool? status;
  bool? emailNotif;
  String? firstAttribute;
  String? secondAttribute;
  bool? verified;
  String? type;
  List<String>? supporters;
  List<Follower>? followers;
  List<Following>? following;
  List<String>? posts;
  List<String>? comments;
  String? sId;
  String? createdAt;
  String? updatedAt;


  Follower(
      {this.name,
        this.email,
        this.username,
        this.headerImage,
        this.avatar,
        this.videoUrl,
        this.status,
        this.emailNotif,
        this.firstAttribute,
        this.secondAttribute,
        this.verified,
        this.type,
        this.supporters,
        this.followers,
        this.following,
        this.posts,
        this.comments,
        this.sId,
        this.createdAt,
        this.updatedAt,});

  Follower.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    headerImage = json['headerImage'];
    avatar = json['avatar'];
    videoUrl = json['videoUrl'];
    status = json['status'];
    emailNotif = json['emailNotif'];
    firstAttribute = json['firstAttribute'];
    secondAttribute = json['secondAttribute'];
    verified = json['verified'];
    type = json['type'];
    supporters = json['supporters'].cast<String>();
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        followers!.add(new Follower.fromJson(v));
      });
    }
    if (json['following'] != null) {
      following = [];
      json['following'].forEach((v) {
        following!.add(new Following.fromJson(v));
      });
    }
    posts = json['posts'].cast<String>();

    comments = json['comments'].cast<String>();
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['headerImage'] = this.headerImage;
    data['avatar'] = this.avatar;
    data['videoUrl'] = this.videoUrl;
    data['status'] = this.status;
    data['emailNotif'] = this.emailNotif;
    data['firstAttribute'] = this.firstAttribute;
    data['secondAttribute'] = this.secondAttribute;
    data['verified'] = this.verified;
    data['type'] = this.type;
    data['supporters'] = this.supporters;
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    if (this.following != null) {
      data['following'] = this.following!.map((v) => v.toJson()).toList();
    }
    data['posts'] = this.posts;

    data['comments'] = this.comments;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Following {
  String? name;
  String? email;
  String? username;
  String? headerImage;
  String? avatar;
  String? videoUrl;
  bool? status;
  bool? emailNotif;
  String? firstAttribute;
  String? secondAttribute;
  bool? verified;
  String? type;
  List<String>? supporters;
  List<Follower>? followers;
  List<Following>? following;
  List<String>? posts;
  List<String>? comments;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Following(
      {this.name,
        this.email,
        this.username,
        this.headerImage,
        this.avatar,
        this.videoUrl,
        this.status,
        this.emailNotif,
        this.firstAttribute,
        this.secondAttribute,
        this.verified,
        this.type,
        this.supporters,
        this.followers,
        this.following,
        this.posts,
        this.comments,
        this.sId,
        this.createdAt,
        this.updatedAt,});

  Following.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    headerImage = json['headerImage'];
    avatar = json['avatar'];
    videoUrl = json['videoUrl'];
    status = json['status'];
    emailNotif = json['emailNotif'];
    firstAttribute = json['firstAttribute'];
    secondAttribute = json['secondAttribute'];
    verified = json['verified'];
    type = json['type'];
    supporters = json['supporters'].cast<String>();
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        followers!.add(new Follower.fromJson(v));
      });
    }
    if (json['following'] != null) {
      following = [];
      json['following'].forEach((v) {
        following!.add(new Following.fromJson(v));
      });
    }
    posts = json['posts'].cast<String>();

    comments = json['comments'].cast<String>();
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['headerImage'] = this.headerImage;
    data['avatar'] = this.avatar;
    data['videoUrl'] = this.videoUrl;
    data['status'] = this.status;
    data['emailNotif'] = this.emailNotif;
    data['firstAttribute'] = this.firstAttribute;
    data['secondAttribute'] = this.secondAttribute;
    data['verified'] = this.verified;
    data['type'] = this.type;
    data['supporters'] = this.supporters;
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    if (this.following != null) {
      data['following'] = this.following!.map((v) => v.toJson()).toList();
    }
    data['posts'] = this.posts;

    data['comments'] = this.comments;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}