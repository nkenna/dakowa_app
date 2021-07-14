import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:dakowa_app/utils/projectcolor.dart';



class LoadingControl {
  static String msg = "Please wait....";
  
  static showLoading(){
    EasyLoading.show(status: msg);
  }

  static dismissLoading(){
    EasyLoading.dismiss(animation: true);
  }

  static showSnackBar(String title, String msg, Widget icon){
    Get.snackbar(
        title,
        msg,
        backgroundColor: mainColor,
        colorText: Colors.white,
        shouldIconPulse: true,
        icon: icon,
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM
    );
  }



}

