import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/screens/auth/loginscreen.dart';
import 'package:dakowa_app/screens/auth/signup.dart';
import 'package:dakowa_app/screens/landing/landingscreen.dart';
import 'package:dakowa_app/screens/search/creatorsallscreen.dart';
import 'package:dakowa_app/screens/support/creatorsupportscreen.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:dakowa_app/utils/sharedprefs.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   checkAuth() async{
    final int? ft = await SharedPrefs.instance.retrieveInt("firsttime");
    if(ft == null){ // this is the first time
      Future.delayed(Duration(seconds: 5), (){
        SharedPrefs.instance.saveInt("firsttime", 1);
        Get.offAll(() => SignupScreen());
      });
    }else if(ft == 1){ // this is not the first time
      String email = await SharedPrefs.instance.retrieveString("email");
      String password = await SharedPrefs.instance.retrieveString("password");
      if(email == null || password == null){ // email or password is null, go to login
        SharedPrefs.instance.saveInt("firsttime", 1);
        Get.offAll(() => LoginScreen());
      }else if(email.isEmpty || password.isEmpty){ // email or password is empty, go to login
        SharedPrefs.instance.saveInt("firsttime", 1);
        Get.offAll(() => LoginScreen());
      }

      final resp = await Provider.of<AuthProvider>(context, listen: false).loginUserSplash(email, password, context);

      if(resp){
        SharedPrefs.instance.saveInt("firsttime", 1);
        Get.offAll(() => LandingScreen());
      }else{
        SharedPrefs.instance.saveInt("firsttime", 1);
        Get.offAll(() => LoginScreen());
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/main_logo.png", width: Get.width * 0.7,),
            SizedBox(height: 2,),
            Text("Fixing you up to fly...", style: TextStyle(letterSpacing: 0.5, color: Colors.white, fontFamily: 'KiwiLight', fontSize: 14),),
            SizedBox(height: 20,),
            CircularProgressIndicator.adaptive(backgroundColor: Color(0xff7cb32f),)

          ],
        ),
      ),
    );
  }

   @override
  void initState() {
     FirebaseInAppMessaging.instance.setMessagesSuppressed(true);
     initDynamicLinks();
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        checkAuth()
    );
  }

   Future<void> initDynamicLinks() async {
     print("XXXXXXXXXCCCCCCCCCCCMMMMMMMMMMMM");
     FirebaseDynamicLinks.instance.onLink(
         onSuccess: (PendingDynamicLinkData? dynamicLink) async {
           final Uri? deepLink = dynamicLink?.link;
           print(deepLink!);

           if (deepLink != null) {
             // ignore: unawaited_futures
             print("USED HEREEEEEE");
             Map<String, String> goal = deepLink.queryParameters;
             print(goal['name']);
             if(goal['name'] != null){
               Get.to(() => CreatorScreenScreen(username: goal['name']));
             }

            // Navigator.pushNamed(context, deepLink.path);
           }
         }, onError: (OnLinkErrorException e) async {
       print('onLinkError');
       print(e.message);
     });

     final PendingDynamicLinkData? data =
     await FirebaseDynamicLinks.instance.getInitialLink();
     final Uri? deepLink = data?.link;


     if (deepLink != null) {
       // ignore: unawaited_futures
       print("USED HEREEEEEE@@");
        Map<String, String> goal = deepLink.queryParameters;
        print(goal);
       Navigator.pushNamed(context, deepLink.path);
     }
   }
}
