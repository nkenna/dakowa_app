import 'dart:async';

import 'package:dakowa_app/models/goal.dart';
import 'package:dakowa_app/models/post.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/services/searchhttpservice.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:dakowa_app/utils/sharedprefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final SearchHttpService _httpService = SearchHttpService();
  List<User> _creators = [];
  List<Post> _posts = [];
  List<Goal> _goals = [];
  Future<Map<String, dynamic>?>? _futureData;
  List<String> _searches = [];

  List<String> get searches => _searches;
  Future<Map<String, dynamic>?>? get futureData => _futureData;
  List<Goal> get goals => _goals;
  List<User> get creators => _creators;
  List<Post> get posts => _posts;

  SearchProvider.init();

  Future<List<String>?> retrieveSearches() async{

    List<String>? dd = await SharedPrefs.instance.retrieveSearch();
    print("SESRCHHHHHH");
    print(dd);
    if(dd != null){
      _searches.clear();
      _searches.addAll(dd);
    }
   return _searches;
  }

  saveSearches(String ss){
    if(_searches.contains(ss) == false){
      _searches.add(ss);
      SharedPrefs.instance.saveSearch(searches);
      notifyListeners();
    }

  }

  setFutureSearch(Future<Map<String, dynamic>?>? dd){
    _futureData = dd;
  }

  Future<Map<String, dynamic>?>? search (String query) async {
    //LoadingControl.showLoading();
    saveSearches(query);

    final response = await _httpService.searchQueryRequest(query);

    if(response == null){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "It seems you are having network issues. Please check the internet conncetivity and try again.",
          Icon(Icons.warning_rounded, color: Colors.orange,)
      );

      return null;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      LoadingControl.dismissLoading();
      _posts.clear();
      _creators.clear();
      _goals.clear();

      List<Post> pss = [];

      var dataPosts = payload['posts'];

      for(var i = 0; i < dataPosts.length; i++){
        try{
          Post p = Post.fromJson(dataPosts[i]);
          pss.add(p);
        }catch(e){
          print(e);
        }
      }
      _posts.addAll(pss);

      List<Goal> gss = [];
      var dataGoals = payload['goals'];

      for(var i = 0; i < dataGoals.length; i++){
        try{
          Goal g = Goal.fromJson(dataGoals[i]);
          gss.add(g);
        }catch(e){
          print(e);
        }
      }

      _goals.addAll(gss);

      List<User> uss = [];
      var dataCreators = payload['creators'];

      for(var i = 0; i < dataCreators.length; i++){
        try{
          User c = User.fromJson(dataCreators[i]);
          uss.add(c);
        }catch(e){
          print(e);
        }
      }

      _creators.addAll(uss);

      Map<String, dynamic> dataAll = Map<String, dynamic>();
      dataAll['creators'] = _creators;
      dataAll['goals'] = _goals;
      dataAll['posts'] = _posts;

      return dataAll;

    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Your request could not be processed. Check your inputs and try again.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return null;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "An error occurred. Don't worry, we are working on it.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return null;
    }
    else if(statusCode == 404){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "The account data was not found",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return null;
    }
    else if(statusCode == 401){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return null;
    }
    else if(statusCode == 409){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Invalid account details",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return null;
    }
    else if(statusCode == 403){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return null;
    }
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );


      return null;
    }
    else {
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "Unknown server error occurred. If it persists, please contact support.",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      return null;
    }
  }
}