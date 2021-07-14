import 'dart:convert';

import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/screens/auth/loginscreen.dart';
import 'package:dakowa_app/screens/auth/resendemailscreen.dart';
import 'package:dakowa_app/screens/landing/landingscreen.dart';
import 'package:dakowa_app/services/authhttpservice.dart';
import 'package:dakowa_app/utils/loadingcontrol.dart';
import 'package:dakowa_app/utils/sharedprefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthProvider with ChangeNotifier {
  final AuthHttpService _httpService = AuthHttpService();
  String? _username;
  bool _verified = false;
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;
  String? get username => _username;
  bool get verified => _verified;

  AuthProvider.init();


  void saveUser(User us){
    SharedPrefs.instance.setUserData(us);
  }

  retrieveUser() async{
   // late User us;
    final data = await SharedPrefs.instance.retrieveString("user");
    if(data != null && data.isNotEmpty){
      print(data);
      User us = User.fromJson(jsonDecode(data));
      if(us != null){
        _user = us;
      }
    }



  }

  bool checkAuthenication() {
    retrieveUser();
    if(user != null){
      return true;
    }else{
      return false;
    }
  }

  void saveToken(String tk){
    SharedPrefs.instance.saveString("token", tk);
  }

  Future<bool?> createUserWithoutUserName (String email, String password) async {
    LoadingControl.showLoading();

    final response = await _httpService.createUserWithoutuserNameRequest(email, password);

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
        "User account created successfully. Check your email box for a verification message. In case, you did not receive the email, check your spam inbox before requesting again.",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );
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
    else if(statusCode == 409){
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

      Get.to(() => ResendEmailScreen());

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

  Future<bool?> createUserWithUserName (String email, String password, String type, String username) async {
    LoadingControl.showLoading();

    final response = await _httpService.createUserWithUserNameRequest(email, password, type, username);

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
        "User account created successfully. Check your email box for a verification message. In case, you did not receive the email, check your spam inbox before requesting again.",
        Icon(Icons.check_box_rounded, color: Colors.green,)
    );
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
    else if(statusCode == 409){
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

      Get.to(() => ResendEmailScreen());

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

  Future<bool> loginUser (String email, String password, BuildContext context) async {
    LoadingControl.showLoading();

    final response = await _httpService.loginUserRequest(email, password);

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
      print("the token");
      print(payload['token']);
      print(payload['user']);
      //saveToken(payload['token']);
      SharedPrefs.instance.saveString("email", email);
      SharedPrefs.instance.saveString("password", password);

      SharedPrefs.instance.saveToken("token", payload['token']).then((value) {
        User us = User.fromJson(payload['user']);
        if(us != null){
          _user = us;
          saveUser(us);
        }

        LoadingControl.dismissLoading();
        LoadingControl.showSnackBar(
            "Success!!!",
            "user authentication success",
            Icon(Icons.check_box_rounded, color: Colors.green,)
        );

       Future.delayed(Duration(seconds: 1), () => Get.offAll(() => LandingScreen()));
      });

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

      Get.to(() => ResendEmailScreen());

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

  Future<bool> changePassword (String currentPassword, String newPassword, String userId) async {
    LoadingControl.showLoading();

    final response = await _httpService.changePasswordRequest(currentPassword, newPassword, userId);

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
          "Password change is successful. You will not be logged out.",
          Icon(Icons.check_box_rounded, color: Colors.green,)
      );

      SharedPrefs.instance.clearData();
     Future.delayed(Duration(seconds: 2), () => Get.offAll(() => LoginScreen()));


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

      Get.to(() => ResendEmailScreen());

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

  Future<bool> loginUserSplash (String email, String password, BuildContext context) async {


    final response = await _httpService.loginUserRequest(email, password);

    if(response == null){
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(response);
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      print("the token");
      print(payload['token']);
      print(payload['user']);
      //saveToken(payload['token']);
      SharedPrefs.instance.saveString("email", email);
      SharedPrefs.instance.saveString("password", password);

      SharedPrefs.instance.saveToken("token", payload['token']).then((value) {
        User us = User.fromJson(payload['user']);
        if(us != null){
          _user = us;
          saveUser(us);
        }

        LoadingControl.dismissLoading();

        Future.delayed(Duration(seconds: 1), () => Get.offAll(() => LandingScreen()));
      });

      return true;
    }
    else if(statusCode == 422){
      print("error of 422");

      LoadingControl.dismissLoading();

      return false;
    }
    else if(statusCode == 500){
      LoadingControl.dismissLoading();

      return false;
    }
    else if(statusCode == 404){
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
    else if(statusCode == 423){
      LoadingControl.dismissLoading();

      Get.to(() => ResendEmailScreen());

      return false;
    }
    else {
      LoadingControl.dismissLoading();

      return false;
    }
  }

  Future<bool> resetPassword(BuildContext context, String code, String password) async {
    LoadingControl.showLoading();

    final response = await _httpService.resetPasswordRequest(code, password);

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

      // LoadingControl.dismissLoading();

      //notifyListeners();
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
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      Get.to(() => ResendEmailScreen());

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


  Future<bool> sendEmailReset(BuildContext context, String email) async {
    LoadingControl.showLoading();

    final response = await _httpService.forgotEmailRequest(email);

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



      //notifyListeners();
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
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      Get.to(() => ResendEmailScreen());

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

  Future<bool> resendEmail(BuildContext context, String email) async {
    LoadingControl.showLoading();

    final response = await _httpService.resendEmailRequest(email);

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


      //notifyListeners();
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
    else if(statusCode == 423){
      LoadingControl.dismissLoading();
      LoadingControl.showSnackBar(
          "Ouchs!!!",
          "${payload['message']}",
          Icon(Icons.error_rounded, color: Colors.orange,)
      );

      Get.to(() => ResendEmailScreen());

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

