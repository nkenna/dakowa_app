class Post {
  String? title;
  String? content;
  String? type;
  List<String>? mediaUrl;
  String? username;
  String? userId;
  bool? flag;
  List<Comments>? comments;
  List<Like>? likes;
  Owner? owner;
  String? createdAt;
  String? updatedAt;
  String? id;

  Post(
      {this.title,
        this.content,
        this.type,
        this.mediaUrl,
        this.username,
        this.userId,
        this.likes,
        this.flag,
        this.comments,
        this.owner,
        this.createdAt,
        this.updatedAt,
        this.id});

  Post.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    type = json['type'];
    mediaUrl = json['mediaUrl'].cast<String>();
    username = json['username'];
    userId = json['userId'];
    flag = json['flag'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        if(v.runtimeType == String){
          comments!.add(new Comments(sId: v));
        }else{
          comments!.add(new Comments.fromJson(v));
        }
      });
    }

    if (json['likes'] != null) {
      print("VVVVVVVVVVV");
      print(json['likes']);
      likes = [];
      json['likes'].forEach((v) {
        print(v);
        if(v.runtimeType == String){
          likes!.add(new Like(sId: v));
        }else{
          likes!.add(new Like.fromJson(v));
        }
      });
    }

    if(json['owner'] != null){
      if(json['owner'].runtimeType == String){
        owner = new Owner(sId: json['owner']);
      }else{
        owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
      }
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['type'] = this.type;
    data['mediaUrl'] = this.mediaUrl;
    data['username'] = this.username;
    data['userId'] = this.userId;
    data['flag'] = this.flag;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class Comments {
  String? content;
  String? commenterId;
  String? userId;
  bool? flag;
  bool? isReply;
  String? commentId;
  List<Replies>? replies;
  String? sId;
  String? post;
  Commenter? commenter;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Comments(
      {this.content,
        this.commenterId,
        this.userId,
        this.flag,
        this.isReply,
        this.commentId,
        this.replies,
        this.sId,
        this.post,
        this.commenter,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Comments.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    commenterId = json['commenterId'];
    userId = json['userId'];
    flag = json['flag'];
    isReply = json['isReply'];
    commentId = json['commentId'];
    if (json['replies'] != null) {

      replies = [];
      json['replies'].forEach((v) {
        if(v.runtimeType == String){
          replies!.add(new Replies(sId: v));
        }else{
          replies!.add(new Replies.fromJson(v));
        }
      });
    }
    sId = json['_id'];
    post = json['post'];
    if(json['commenter'] != null){
      if(json['commenter'].runtimeType == String){
        commenter = new Commenter(sId: json['commenter']);
      }else{
        commenter = json['commenter'] != null ? new Commenter.fromJson(json['commenter']) : null;
      }
    }

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['commenterId'] = this.commenterId;
    data['userId'] = this.userId;
    data['flag'] = this.flag;
    data['isReply'] = this.isReply;
    data['commentId'] = this.commentId;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['post'] = this.post;
    if (this.commenter != null) {
      data['commenter'] = this.commenter!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Replies {
  String? content;
  String? commenterId;
  String? userId;
  bool? flag;
  bool? isReply;
  String? commentId;
  String? sId;
  String? post;
  String? comment;
  String? commenter;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Replies(
      {this.content,
        this.commenterId,
        this.userId,
        this.flag,
        this.isReply,
        this.commentId,
        this.sId,
        this.post,
        this.comment,
        this.commenter,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Replies.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    commenterId = json['commenterId'];
    userId = json['userId'];
    flag = json['flag'];
    isReply = json['isReply'];
    commentId = json['commentId'];
    sId = json['_id'];
    post = json['post'];
    comment = json['comment'];
    commenter = json['commenter'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['commenterId'] = this.commenterId;
    data['userId'] = this.userId;
    data['flag'] = this.flag;
    data['isReply'] = this.isReply;
    data['commentId'] = this.commentId;
    data['_id'] = this.sId;
    data['post'] = this.post;
    data['comment'] = this.comment;
    data['commenter'] = this.commenter;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Commenter {
  String? name;
  String? email;
  String? username;
  String? headerImage;
  String? avatar;
  //double karfa;
  String? videoUrl;
  bool? status;
  String? firstAttribute;
  String? secondAttribute;
  bool? verified;
  String? type;
  String? pocketRef;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? pocket;

  Commenter(
      {this.name,
        this.email,
        this.username,
        this.headerImage,
        this.avatar,
        //this.karfa,
        this.videoUrl,
        this.status,
        this.firstAttribute,
        this.secondAttribute,
        this.verified,
        this.type,
        this.pocketRef,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.pocket});

  Commenter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    headerImage = json['headerImage'];
    avatar = json['avatar'];
    //karfa = json['karfa'].toDouble();
    videoUrl = json['videoUrl'];
    status = json['status'];
    firstAttribute = json['firstAttribute'];
    secondAttribute = json['secondAttribute'];
    verified = json['verified'];
    type = json['type'];
    pocketRef = json['pocketRef'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    pocket = json['pocket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['headerImage'] = this.headerImage;
    data['avatar'] = this.avatar;
    //data['karfa'] = this.karfa;
    data['videoUrl'] = this.videoUrl;
    data['status'] = this.status;
    data['firstAttribute'] = this.firstAttribute;
    data['secondAttribute'] = this.secondAttribute;
    data['verified'] = this.verified;
    data['type'] = this.type;
    data['pocketRef'] = this.pocketRef;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['pocket'] = this.pocket;
    return data;
  }
}

class Owner {
  String? name;
  String? email;
  String? username;
  String? headerImage;
  String? avatar;
  //double karfa;
  String? videoUrl;
  bool? status;
  String? firstAttribute;
  String? secondAttribute;
  bool? verified;
  String? type;
  String? pocketRef;
  String? sId;

  Owner(
      {this.name,
        this.email,
        this.username,
        this.headerImage,
        this.avatar,
        //this.karfa,
        this.videoUrl,
        this.status,
        this.firstAttribute,
        this.secondAttribute,
        this.verified,
        this.type,
        this.pocketRef,
        this.sId});

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    headerImage = json['headerImage'];
    avatar = json['avatar'];
    //karfa = json['karfa'].toDouble();
    videoUrl = json['videoUrl'];
    status = json['status'];
    firstAttribute = json['firstAttribute'];
    secondAttribute = json['secondAttribute'];
    verified = json['verified'];
    type = json['type'];
    pocketRef = json['pocketRef'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['headerImage'] = this.headerImage;
    data['avatar'] = this.avatar;
    //data['karfa'] = this.karfa;
    data['videoUrl'] = this.videoUrl;
    data['status'] = this.status;
    data['firstAttribute'] = this.firstAttribute;
    data['secondAttribute'] = this.secondAttribute;
    data['verified'] = this.verified;
    data['type'] = this.type;
    data['pocketRef'] = this.pocketRef;
    data['_id'] = this.sId;
    return data;
  }
}

class Like {
  String? postId;
  String? likedById;
  String? sId;
  String? post;
  LikedBy? likedBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Like(
      {this.postId,
        this.likedById,
        this.sId,
        this.post,
        this.likedBy,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Like.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    likedById = json['likedById'];
    sId = json['_id'];
    post = json['post'];
    likedBy =
    json['likedBy'] != null ? new LikedBy.fromJson(json['likedBy']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['likedById'] = this.likedById;
    data['_id'] = this.sId;
    data['post'] = this.post;
    if (this.likedBy != null) {
      data['likedBy'] = this.likedBy!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class LikedBy {
  String? name;
  String? email;
  String? username;
  String? headerImage;
  String? avatar;
  String? videoUrl;
  bool? status;
  String? firstAttribute;
  String? secondAttribute;
  bool? verified;
  String? type;
  String? pocketRef;
  String? sId;

  LikedBy(
      {this.name,
        this.email,
        this.username,
        this.headerImage,
        this.avatar,
        this.videoUrl,
        this.status,
        this.firstAttribute,
        this.secondAttribute,
        this.verified,
        this.type,
        this.pocketRef,
        this.sId});

  LikedBy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    headerImage = json['headerImage'];
    avatar = json['avatar'];
    videoUrl = json['videoUrl'];
    status = json['status'];
    firstAttribute = json['firstAttribute'];
    secondAttribute = json['secondAttribute'];
    verified = json['verified'];
    type = json['type'];
    pocketRef = json['pocketRef'];
    sId = json['_id'];
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
    data['firstAttribute'] = this.firstAttribute;
    data['secondAttribute'] = this.secondAttribute;
    data['verified'] = this.verified;
    data['type'] = this.type;
    data['pocketRef'] = this.pocketRef;
    data['_id'] = this.sId;
    return data;
  }
}