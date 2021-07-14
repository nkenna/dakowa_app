import 'dart:typed_data';

import 'package:dakowa_app/models/bank.dart';
import 'package:dakowa_app/models/bankdata.dart';
import 'package:dakowa_app/models/goal.dart';
import 'package:dakowa_app/models/post.dart';
import 'package:dakowa_app/models/support.dart';
import 'package:dakowa_app/models/supporter.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/screens/dashboard/goals/goalsscreen.dart';
import 'package:dakowa_app/screens/dashboard/landing/dashboardhome.dart';
import 'package:dakowa_app/screens/dashboard/posts/postsscreen.dart';
import 'package:dakowa_app/screens/dashboard/settings/settingsscreen.dart';
import 'package:dakowa_app/screens/dashboard/supporters/supportersscreen.dart';
import 'package:dakowa_app/screens/dashboard/supports/supportsscreen.dart';
import 'package:dakowa_app/services/dashboardhttpservice.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardProvider with ChangeNotifier {
  final DashboardHttpService _httpService = DashboardHttpService();

  List<Widget> _dashboardScreens = [
    DashBoardHome(),
    GoalsScreen(),
    Supportersscreen(),
    SupportsScreen(),
    PostsScreen(),
    SettingsScreen(),
  ];

  int _currentScreen = 0;
  User? _creator;
  List<Support> _supports = [];
  List<Goal> _goals = [];
  List<Supporter> _supporters = [];
  List<Post> _posts = [];
  List<Bank> _banks = [];
  BankData? _bankData;
  int _activeGoals = 0;
  bool _toggleDrawer = false;

  bool get toggleDrawer => _toggleDrawer;
  int get activeGoals => _activeGoals;
  BankData? get bankData => _bankData;
  List<Bank> get banks => _banks;
  List<Post> get posts => _posts;
  List<Support> get supports => _supports;
  List<Goal> get goals => _goals;
  List<Supporter> get supporters => _supporters;
  User? get creator => _creator;
  List<Widget> get dashboardScreens => _dashboardScreens;
  int get currentScreen => _currentScreen;

  DashBoardProvider.init();

  void setToggleDrawer(bool value){
    _toggleDrawer = value;
    notifyListeners();
  }

  void setBankData(BankData bd){
    _bankData = bd;
  }

  void setCurrentScreen(int scr){
    _currentScreen = scr;
    notifyListeners();
  }

  void setCurrentUser(User us){
    if(us != null){
      _creator = us;
    }
  }

  Future<bool> creatorProfile (String username) async {
    LoadingControl.showLoading();

    final response = await _httpService.userProfileSupportRequest(username);

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

      User us = User.fromJson(payload['user']);
      if(us != null){
        _creator = us;
      }
      //creatorSupporters(_context, _creator.username);
      if(_creator != null){
        print(_creator!.videoUrl);

      }
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

  Future<bool> creatorSupports(String username) async {
    //LoadingControl.showLoading();

    final response = await _httpService.creatorSupportsRequest(username);

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
      _supports.clear();
      var data = payload['supports'];

      print("len of supports::: ${data.length}");
      for(var i = 0; i < data.length; i++){
        try{
          Support supp = Support.fromJson(data[i]);
          if(supp != null){
            _supports.add(supp);
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

  Future<bool> createGoal(String title,
      String mode,
      bool active,
      double maxAmount,
      String note,
      String username,
      String startDate,
      String endDate) async {
    LoadingControl.showLoading();

    final response = await _httpService.createGoalRequest(title, mode, active, maxAmount, note, username, startDate, endDate);

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

  Future<bool> creatorGoals(String username) async {
    LoadingControl.showLoading();

    final response = await _httpService.creatorGoalsRequest(username);

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
      LoadingControl.dismissLoading();
      _goals.clear();
      List<Goal> gs = [];
      var data = payload['goals'];
      print("len of goals::: ${data.length}");
      for(var i = 0; i < data.length; i++){
        try{
          Goal supp = Goal.fromJson(data[i]);
          if(supp != null){
            gs.add(supp);

          }
        }catch(e){
          print(e);
        }
      }
      _goals.addAll(gs);
      _activeGoals = _goals.where((element) => element.active == true).length;

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

  Future<bool> activateDeactivateGoal(String username, String ref, bool stat) async {
    LoadingControl.showLoading();

    final response = await _httpService.activateDeactivateGoalRequest(username, ref, stat);

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
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "Goal status successfully changed",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );

      await creatorGoals(_creator!.username!);

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

  Future<bool> creatorSupporters(String username) async {
    LoadingControl.showLoading();

    final response = await _httpService.creatorSupportersRequest(username);

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

  Future<bool?> userPosts(String userId) async {
    LoadingControl.showLoading();
    final response = await _httpService.userPostsRequest(_creator!.id!);

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
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      _posts.clear();
      List<Post> pss = [];
      var data = payload['posts'];
      for(var i = 0; i < data.length; i++){
        try{
          Post p = Post.fromJson(data[i]);
          if(p != null){
            pss.add(p);
          }
        }catch(e){
          print(e);
        }
      }
      _posts.addAll(pss);
      LoadingControl.dismissLoading();
      notifyListeners();


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

  void searchPosts(String query) async {
    LoadingControl.showLoading();

    final response = await _httpService.searchPostsRequest(query);

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
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){

      List<Post> pss = [];
      var data = payload['posts'];

      _posts.clear();
      for(var i = 0; i < data.length; i++){
        try{
          Post p = Post.fromJson(data[i]);
          if(p != null){
            pss.add(p);
          }
        }catch(e){
          print(e);
        }
      }
      _posts.addAll(pss);


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

  Future<bool> deletePost(BuildContext context, String userId, String postId) async {
    LoadingControl.showLoading();

    final response = await _httpService.deletePostRequest(userId, postId);

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
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "Post deleted successfully",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );


      notifyListeners();
      userPosts(_creator!.id!);

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

  Future<bool> createPost(BuildContext context, String title,
      String content,
      String mediaUrl,
      String username,
      String ownerId,
      String type,
      Uint8List fileBytes) async {
    LoadingControl.showLoading();

    final response = await _httpService.createPostRequest(title, content, mediaUrl, username, ownerId, type, fileBytes);

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
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "Post created successfully",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );


      LoadingControl.dismissLoading();

      notifyListeners();
      userPosts(_creator!.id!);

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

  Future<bool> dakowaBanks() async {
    LoadingControl.showLoading();

    final response = await _httpService.dakowaBanksRequest();

    if(response == null){
      if(response == null){
        LoadingControl.dismissLoading();
        LoadingControl.showSnackBar(
            "Ouchs!!!",
            "Seems you are not connected to internet. Check your connection and try again. Contact support if it persists.",
            Icon(Icons.error, color: Colors.red,)
        );
        return false;
      }

      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      _banks = [];
      List<Bank> bss = [];
      var data = payload['banks'];

      print("len of banks::: ${data.length}");
      for(var i = 0; i < data.length; i++){
        try{
          Bank supp = Bank.fromJson(data[i]);
          if(supp != null){
            bss.add(supp);

          }
        }catch(e){
          print(e);
        }
      }
      _banks.addAll(bss);
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
    else if(statusCode == 400){
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

  Future<bool> verifyBankInfo(String accountNumber, String bankCode) async {
    LoadingControl.showLoading();

    final response = await _httpService.verifyBankInfoRequest(accountNumber, bankCode);

    if(response == null){
      if(response == null){
        LoadingControl.dismissLoading();
        LoadingControl.showSnackBar(
            "Ouchs!!!",
            "Seems you are not connected to internet. Check your connection and try again. Contact support if it persists.",
            Icon(Icons.error, color: Colors.red,)
        );
        return false;
      }

      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      try{
        BankData bdd = BankData.fromJson(payload['bankData']);
        if(bdd != null){
          _bankData = bdd;
        }
      }catch(e){
        print(e);
        LoadingControl.showSnackBar(
            "Ouchs!!!",
            "The response could not be processed.",
            Icon(Icons.error, color: Colors.red,)
        );

        return false;
      }

      LoadingControl.showSnackBar(
          "Success!!!",
          "Bank Info Verified successfully",
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
    else if(statusCode == 400){
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

  Future<bool> createBankInfo(
      String accountNumber,
      String bankCode,
      String creatorUsername,
      String ownerName,
      String bankName) async {
    LoadingControl.showLoading();

    final response = await _httpService.createBankInfoRequest(accountNumber, bankCode, creatorUsername, ownerName, bankName);

    if(response == null){
      if(response == null){
        LoadingControl.dismissLoading();
        LoadingControl.showSnackBar(
            "Ouchs!!!",
            "Seems you are not connected to internet. Check your connection and try again. Contact support if it persists.",
            Icon(Icons.error, color: Colors.red,)
        );
        return false;
      }

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
          "Bank Info added successfully",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );


      notifyListeners();

      creatorProfile (_creator!.username!);
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
    else if(statusCode == 400){
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


  Future<bool> editBankInfo(
      String accountNumber,
      String bankCode,
      String creatorUsername,
      String ownerName,
      String bankName,
      int recipId) async {
    LoadingControl.showLoading();

    final response = await _httpService.editBankInfoRequest(accountNumber, bankCode, creatorUsername, ownerName, bankName, recipId);

    if(response == null){
      if(response == null){
        LoadingControl.dismissLoading();
        LoadingControl.showSnackBar(
            "Ouchs!!!",
            "Seems you are not connected to internet. Check your connection and try again. Contact support if it persists.",
            Icon(Icons.error, color: Colors.red,)
        );
        return false;
      }

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
          "Bank Info updated successfully",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );



      notifyListeners();

      creatorProfile (_creator!.username!);


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
    else if(statusCode == 400){
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


  Future<bool> editCreatorProfile(
      String name,
      String username,
      double karfa,
      String firstAttribute,
      String secondAttribute,
      String videoUrl) async {
    LoadingControl.showLoading();

    final response = await _httpService.editCreatorProfileRequest(name, username, karfa, firstAttribute, secondAttribute, videoUrl);

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
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "Profile updated successfully",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );
  ;

      notifyListeners();

      creatorProfile (_creator!.username!);
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
    else if(statusCode == 400){
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


  Future<bool> sendMessage(BuildContext context, String content, String senderId, String receiverId, String receiverEmail) async {
    LoadingControl.showLoading();

    final response = await _httpService.sendMessageRequest(content, senderId, receiverId, receiverEmail);

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
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "Message sent successfully",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );
         notifyListeners();

      creatorProfile (_creator!.username!);
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

  void searchGoals(String query, String username) async {
    LoadingControl.showLoading();

    final response = await _httpService.searchGoalsRequest(query, username);

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
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){

      List<Goal> pss = [];
      var data = payload['goals'];

      _goals.clear();
      for(var i = 0; i < data.length; i++){
        try{
          Goal p = Goal.fromJson(data[i]);
          if(p != null){
            pss.add(p);
          }
        }catch(e){
          print(e);
        }
      }
      _goals.addAll(pss);


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

  Future<bool> exportSupporters(String username) async {
    LoadingControl.showLoading();

    final response = await _httpService.exportSupportersRequest(username);

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
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Success!!!",
          "Supporters exported successfully. Check your email inbox.",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );


      notifyListeners();
      //creatorProfile (_creator.username);
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


}