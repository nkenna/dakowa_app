import 'package:dakowa_app/models/goal.dart';
import 'package:dakowa_app/models/supporter.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/services/supporthttpservice.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class SupportProvider with ChangeNotifier {
  final SupportHttpService _httpService = SupportHttpService();
  User? _creator;
  YoutubePlayerController? _controller;
  List<Supporter> _supporters = [];
  int _supportersLength = 0;
  bool _validUser = false;
  bool _validGoal = false;
  Goal? _goal;

  bool get validGoal => _validGoal;
  Goal? get goal => _goal;
  bool get validUser => _validUser;
  User? get creator => _creator;
  YoutubePlayerController? get controller => _controller;
  List<Supporter> get supporters => _supporters;
  int get supportersLength => _supportersLength;

  SupportProvider.init();



  setSupportersLength(int len){
    _supportersLength = len;
    notifyListeners();
  }

  setYT(YoutubePlayerController c){
    _controller = c;
    _controller!.onEnterFullscreen = () {
      //SystemChrome.setPreferredOrientations([
      //  DeviceOrientation.landscapeLeft,
      //  DeviceOrientation.landscapeRight,
      //]);
      print('Entered Fullscreen');
    };
    _controller!.onExitFullscreen = () {
      print('Exited Fullscreen');
    };
  }

  closeYT(){
    _controller!.close();
  }

  setYTControllerVideoId(String videoId){
    _controller!.load(videoId);
    notifyListeners();
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
      _creator = us;
      creatorSupporters(_creator!.username!);
      if(_creator != null){
        print(_creator!.videoUrl);
        _validUser = true;
        if(_creator!.videoUrl != null && _creator!.videoUrl!.isNotEmpty){
          var pos = _creator!.videoUrl!.lastIndexOf('=');
          if(pos != -1){
            print(_creator!.videoUrl!.substring(pos + 1));
            setYTControllerVideoId(_creator!.videoUrl!.substring(pos + 1));
          }
          //String result = (pos != -1) ? _creator.videoUrl.substring(0, pos): _creator.videoUrl;
          //print(result);

        }
      }
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

  Future<bool> goalProfile (String username, String ref) async {
    LoadingControl.showLoading();

    final response = await _httpService.goalProfileSupportRequest(username, ref);

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

      try{
        Goal g = Goal.fromJson(payload['goal']);

        if(g != null){
          _goal = g;
          _validGoal = true;
          print(_goal!.creator!.name);
          /* if(_creator.videoUrl != null && _creator.videoUrl.isNotEmpty) {
            var pos = _creator.videoUrl.lastIndexOf('=');
            if (pos != -1) {
              print(_creator.videoUrl.substring(pos + 1));
              setYTControllerVideoId(_creator.videoUrl.substring(pos + 1));
            }
          }*/
          //String result = (pos != -1) ? _creator.videoUrl.substring(0, pos): _creator.videoUrl;
          //print(result);
        }
      }catch(e){
        print(e);
      }


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


  Future<bool> creatorSupport(BuildContext context, String paymentRef, String supporterEmail, String name, String note, bool anonymous, int quantity, String username) async {
    LoadingControl.showLoading();

    final response = await _httpService.creatorSupportRequest(paymentRef, supporterEmail, name, note, anonymous, quantity, username);

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
          "Success",
          "Thanks for supporting this creator",
          Icon(Icons.check, color: mainColor,)
      );


      creatorSupporters(_creator!.username!);
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

  Future<bool> goalSupport(BuildContext context, String paymentRef, String supporterEmail, String name, String note, bool anonymous, String username, String ref) async {
    LoadingControl.showLoading();

    final response = await _httpService.goalSupportRequest(paymentRef, supporterEmail, name, note, anonymous, username, ref);

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
          "Success",
          "Thanks for supporting this goal",
          Icon(Icons.check, color: mainColor,)
      );


      goalProfile(_creator!.username!, _creator!.pocketRef!);

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
    //LoadingControl.showLoading();

    final response = await _httpService.creatorSupportersRequest(username);

    if(response == null){
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
      List<Supporter> suppss = [];
      var data = payload['supporters'];
      print("len of supporters::: ${data.length}");
      for(var i = 0; i < data.length; i++){
        try{
          Supporter supp = Supporter.fromJson(data[i]);
          if(supp != null){
            suppss.add(supp);
            _supportersLength = _supporters.length > 15
                ? _supporters.length - 15
                : _supporters.length;
          }
        }catch(e){
          print(e);
        }
      }
      _supporters.addAll(suppss);
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

}