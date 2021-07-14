import 'dart:io';
import 'dart:typed_data';

import 'package:dakowa_app/models/followdata.dart';
import 'package:dakowa_app/models/post.dart';
import 'package:dakowa_app/models/supporter.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/services/dashboardhttpservice.dart';
import 'package:dakowa_app/services/landinghttpservice.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:dakowa_app/utils/sharedprefs.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:assets_audio_player/assets_audio_player.dart';

class LandingProvider with ChangeNotifier {
  final LandingHttpService _httpService = LandingHttpService();

  List<User> _creators1 = [];
  List<User> _creators2 = [];
  List<User> _creators = [];

  List<Post> _posts = [];
  List<Post> _posts1 = [];
  List<Post> _posts2 = [];

  List<FollowData> _followDatas = [];
  List<FollowData> _followingDatas = [];
  List<Supporter> _supporters = [];

  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  AssetsAudioPlayer get assetsAudioPlayer => _assetsAudioPlayer;
  User? _selectedFollower;
  bool _commentLoading = false;
  Post? _selectedPost;
  Post? get selectedPost => _selectedPost;
  bool get commentLoading => _commentLoading;
  User? get selectedFollower => _selectedFollower;
  List<FollowData> get followDatas => _followDatas;
  List<FollowData> get followingDatas => _followingDatas;
  List<Supporter> get supporters => _supporters;

  List<User> get creators1 => _creators1;
  List<User> get creators2 => _creators2;
  List<User> get creators => _creators;

  List<Post> get posts => _posts;
  List<Post> get posts1 => _posts1;
  List<Post> get posts2 => _posts2;

  LandingProvider.init();

  playAudio(){
    if(Platform.isAndroid){
      final Audio audio = Audio("assets/audio/swiftly-610.mp3");
      _assetsAudioPlayer.open(
        audio,
      );
    }else if(Platform.isIOS){
      final Audio audio = Audio("assets/audio/swiftly-610.m4r");
      _assetsAudioPlayer.open(
        audio
      );
    }

  }

  bool checkFollowing(String followerId, User _user){
    bool isFollowing = false;
    print("is user not null: ${_user != null }");
    if(_user != null){
      for(var i = 0; i < _followingDatas.length; i++){
        if(_followingDatas[i].following!.sId == followerId){
          isFollowing = true;
          break;
        }
      }
    }
    return isFollowing;
  }

  void setSelectedPost(Post p){
    _selectedPost = p;
    notifyListeners();
  }

  void setSelectedFellowerSid(dynamic f){
    //print(f.sid);
    if(f != null){
      User u = User(
        name: f.name,
        id: f.sId,
        username: f.username,
        avatar: f.avatar,
        videoUrl: f.videoUrl,
        email: f.email,
        headerImage: f.headerImage
      );
      _selectedFollower = u;
    }

    //notifyListeners();
  }

  void setSelectedFellowerId(dynamic f){
    //print(f.sid);
    if(f != null){
      User u = User(
          name: f.name,
          id: f.id,
          username: f.username,
          avatar: f.avatar,
          videoUrl: f.videoUrl,
          email: f.email,
          headerImage: f.headerImage
      );
      _selectedFollower = u;
    }

    //notifyListeners();
  }

  void saveUser(User us){
    SharedPrefs.instance.setUserData(us);
  }

  Future<bool> checkLike(List<Like> ls, String userId) async{
    print("FFFFFFFFFFFFFFFFFFFbbbbb");
    print(ls[0] != null ? ls[0].postId : "");
    bool haveLiked = false;
    for(var i = 0; i < ls.length; i++){
      if(userId == ls[i].likedById){
        haveLiked = true;
        break;
      }
    }
    print(haveLiked);
    return haveLiked;
  }



  Future<bool> exploreCreators (String type, String userId) async {
    //LoadingControl.showLoading();

    final response = await _httpService.exploreCreatorsRequest(type);

    if(response == null){
      LoadingControl.dismissLoading();
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      _creators.clear();
      _creators1.clear();
      _creators2.clear();
      List<User> _toRemoveUser = [];
      Map<String, dynamic> inputData = Map<String, dynamic>();
      inputData['responseBody'] = payload['creators'];
      inputData['userId'] = userId;
      _creators.addAll(await compute(_computeAllCreators, inputData ));
      if(_creators.length > 100){
        _creators1 = _creators.sublist(0, (_creators.length~/2).toInt());
        _creators2 = _creators.sublist((_creators.length~/2).toInt() + 1);
      }else{
        _creators1.clear();
        _creators1.addAll(_creators);
      }
      notifyListeners();
      return true;


    }else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      return false;
    }


    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      return false;
    }

    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
     return false;
    }
    else {
      LoadingControl.dismissLoading();


      return false;
    }
  }

  Future<bool> checkUsername (String newUsername) async {
    LoadingControl.showLoading();

    final response = await _httpService.checkUsernameRequest(newUsername);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "It seems you are having network issues. Please check the internet conncetivity and try again.",
          Icon(Icons.warning_rounded, color: Colors.orange,)
      );

      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();

      // userProfileExplore();
      return true;

      //Future.delayed(Duration(seconds: 2), () => Get.offAllNamed("/explore"));



    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
  }

  Future<bool> upgradeToCreator (String newUsername, String userId) async {
    LoadingControl.showLoading();
    var usn = userId;
    final response = await _httpService.upgradeToCreatorRequest(userId, newUsername);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "It seems you are having network issues. Please check the internet conncetivity and try again.",
          Icon(Icons.warning_rounded, color: Colors.orange,)
      );

      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "${payload['message']}",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );

      Future.delayed(Duration(seconds: 3));
      userProfileExplore(usn);
      return true;

      //Future.delayed(Duration(seconds: 2), () => Get.offAllNamed("/explore"));



    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
  }


  Future<bool> userProfileExplore (String userId) async {
    //LoadingControl.showLoading();

    final response = await _httpService.userProfileExploreRequest(userId);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "It seems you are having network issues. Please check the internet conncetivity and try again.",
          Icon(Icons.warning_rounded, color: Colors.orange,)
      );

      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){

      print(payload['user']);
      //saveToken(payload['token']);
      User us = User.fromJson(payload['user']);
      if(us != null){
        SharedPrefs.instance.setUserData(us);
      }
        LoadingControl.dismissLoading();
       // LoadingControl.showSnackBar(
       //     "Success!!!",
       //     "user authentication success",
       //     Icon(Icons.check_box_rounded, color: Colors.green,)
       // );

      return true;
    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

       return false;
    }
    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
  }

  void userExplorePosts(String userId) async {
    LoadingControl.showLoading();

    final response = await _httpService.userPostsAndFollowersPostRequest(userId);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Seems you are not connected to internet. Check your connection and try again. Contact support if it persists.",
          Icon(Icons.error, color: Colors.red,)
      );
      return null;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload['posts'][0]);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      _posts.clear();
      _posts1.clear();
      _posts2.clear();
      var data = payload['posts'];
      for(var i = 0; i < data.length; i++){
        try{
          Post p = Post.fromJson(data[i]);
          if(p != null){
            _posts.add(p);
          }
        }catch(e){
          print(e);
        }
      }
      if(_posts.length > 50){
        _posts1 = _posts.sublist(0, (_posts.length~/2).toInt());
        _posts2 = _posts.sublist((_posts.length~/2).toInt() + 1);
      }else{
        _posts1.addAll(_posts);
      }
      LoadingControl.dismissLoading();
      notifyListeners();


    }else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error, color: Colors.red,)
      );
      return null;
    }


    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error, color: Colors.red,)
      );
      return null;
    }else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error, color: Colors.red,)
      );
      return null;
    }
  }

  Future<bool> userFollowers (String userId) async {
    //LoadingControl.showLoading();

    final response = await _httpService.userFollowersRequest(userId);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Seems you are not connected to internet. Check your connection and try again. Contact support if it persists.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      List<FollowData> fds = [];
      //User us = User.fromJson(payload['user']);

      var data = payload['followData'];
      for(var i = 0; i < data.length; i++){
        try{
          FollowData fd = FollowData.fromJson(data[i]);
          fds.add(fd);
        }catch(e){
          print(e);
       }
      }

      _followDatas.clear();
      _followDatas.addAll(fds);

      LoadingControl.dismissLoading();


      notifyListeners();


      return true;
    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
  }

  Future<bool> userFollowing (String userId) async {
    //LoadingControl.showLoading();

    final response = await _httpService.userFollowingRequest(userId);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Seems you are not connected to internet. Check your connection and try again. Contact support if it persists.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      List<FollowData> fds = [];
      //User us = User.fromJson(payload['user']);

      var data = payload['followingData'];
      for(var i = 0; i < data.length; i++){
        try{
          FollowData fd = FollowData.fromJson(data[i]);
          fds.add(fd);
        }catch(e){
          print(e);
        }


      }

      _followingDatas.clear();
      _followingDatas.addAll(fds);

      LoadingControl.dismissLoading();


      notifyListeners();


      return true;
    }else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }


    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
  }

  Future<bool> editEmailNotif(String userId, bool emailNotif) async {
    LoadingControl.showLoading();

    final response = await _httpService.editEmailNotifRequest(userId, emailNotif);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "It seems you are having network issues. Please check the internet conncetivity and try again.",
          Icon(Icons.warning_rounded, color: Colors.orange,)
      );

      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "${payload['message']}",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );
      notifyListeners();


      return true;
    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }

    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }

  }

  Future<bool> editFollowerName(String userId, String name) async {
    LoadingControl.showLoading();

    final response = await _httpService.editFollowerNameRequest(userId, name);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "It seems you are having network issues. Please check the internet conncetivity and try again.",
          Icon(Icons.warning_rounded, color: Colors.orange,)
      );

      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "Name updated successfully",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );

      LoadingControl.dismissLoading();

      notifyListeners();
      //userProfileExplore();

      return true;
    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }

    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }

  }

  Future<bool> editFollowerAvatar(String userId, Uint8List fileBytes) async {
    LoadingControl.showLoading();

    final response = await _httpService.editFollowerAvatarRequest(userId, fileBytes);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "It seems you are having network issues. Please check the internet conncetivity and try again.",
          Icon(Icons.warning_rounded, color: Colors.orange,)
      );

      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "Avatar updated successfully",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );


      notifyListeners();
      //userProfileExplore();

      return true;
    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }

    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
  }

  Future<bool> editFollowerHeaderImage(String userId, Uint8List fileBytes) async {
    LoadingControl.showLoading();

    final response = await _httpService.editFollowerHeaderRequest(userId, fileBytes);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "It seems you are having network issues. Please check the internet conncetivity and try again.",
          Icon(Icons.warning_rounded, color: Colors.orange,)
      );

      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "Header Image updated successfully",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );


      notifyListeners();
      //userProfileExplore();

      return true;
    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }

    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }

  }

  Future<bool> createComment(String content, String commenterId, String userId, String postId, bool isReply, String commentId, BuildContext context) async {
    //LoadingControl.showLoading();
    _commentLoading = true;
    notifyListeners();

    final response = await _httpService.createCommentRequest(content, commenterId, userId, postId, isReply, commentId);

    if(response == null){
      _commentLoading = false;
      notifyListeners();
      if(response == null){
        LoadingControl.dismissLoading();
        LoadingControl.showSnackBar(
            "Ouchs!!!",
            "It seems you are having network issues. Please check the internet conncetivity and try again.",
            Icon(Icons.warning_rounded, color: Colors.orange,)
        );

      //  return false;
      }
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      try{
        Post p = Post.fromJson(payload['post']);
        if(p != null){
          p.comments = p.comments!.reversed.toList();
          _selectedPost = p;
        }
      }catch(e){
        print(e);
      }
      _commentLoading = false;
     // notifyListeners();
      return true;
    }

    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 400){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 419){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }

    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
  }

  Future<bool> updateDeviceToken(String userId, String deviceToken) async {


    final response = await _httpService.updateDeviceTokenRequest(userId, deviceToken);

    if(response == null){
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      return true;
    }

    else if(statusCode == 422){

      return false;
    }
    else if(statusCode == 500){

      return false;
    }
    else if(statusCode == 404){

      return false;
    }
    else if(statusCode == 401){

      return false;
    }
    else if(statusCode == 403){

      return false;
    }
    else {

      return false;
    }


  }

  Future<bool> followUser(String userToFollowId, String followerId) async {


    final response = await _httpService.followUserRequest(userToFollowId, followerId);

    if(response == null){
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "You are now following this user",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );
      userProfileExplore(followerId);

      return true;
    }

    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 400){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 419){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }

    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }


  }

  Future<bool> unFollowUser(String userToUnFollowId, String followerId) async {


    final response = await _httpService.unFollowUserRequest(userToUnFollowId, followerId);

    if(response == null){
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "You have unfollowed this user",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );
      userProfileExplore(followerId);

      return true;
    }

    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 400){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 419){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }

    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }


  }

  Future<bool> userSupporters(String username) async {
    final DashboardHttpService _httpDService = DashboardHttpService();
    LoadingControl.showLoading();

    final response = await _httpDService.creatorSupportersRequest(username);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Seems you are not connected to internet. Check your connection and try again. Contact support if it persists.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      _supporters.clear();
      var data = payload['supporters'];
      print("len of supporters::: ${data.length}");
      LoadingControl.dismissLoading();
      for(var i = 0; i < data.length; i++){
        try{
          Supporter supp = Supporter.fromJson(data[i]);
          if(supp != null){
            _supporters.add(supp);

          }
        }catch(e){
          print(e);
        }
      }

      notifyListeners();

      return true;
    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error, color: Colors.red,)
      );
      return false;
    }
  }

  Future<bool> likePost(String likedById, String postId) async {


    final response = await _httpService.likePostRequest(likedById, postId);

    if(response == null){
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      /*LoadingControl.showSnackBar(
          "Success!!!",
          "You have unfollowed this user",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );
      userProfileExplore(followerId);*/

      return true;
    }

    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 400){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 419){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }


  }

  Future<bool> unlikePost(String likedById, String postId) async {


    final response = await _httpService.unlikePostRequest(likedById, postId);

    if(response == null){
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      /*LoadingControl.showSnackBar(
          "Success!!!",
          "You have unfollowed this user",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );
      userProfileExplore(followerId);*/

      return true;
    }

    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 400){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 419){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return false;
    }
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }
    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return false;
    }


  }

}

List<User> _computeAllCreators(Map<String, dynamic> inputData){
  var data = inputData['responseBody'];
  var userId = inputData['userId'];

  List<User> _ccs = [];
  for(var i = 0; i < data.length; i++){
    try{
      User us = User.fromJson(data[i]);
      if(us != null){
        _ccs.add(us);
      }
    }catch(e){
      print(e);
    }
  }

  List<User> ccss = _ccs.where((element) => element.id != userId).toList();
  return ccss;
}

