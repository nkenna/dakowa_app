import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dakowa_app/models/user.dart';
import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/screens/dashboard/landing/dashboardscreen.dart';
import 'package:dakowa_app/screens/landing/explorescreen.dart';
import 'package:dakowa_app/screens/landing/followersscreen.dart';
import 'package:dakowa_app/screens/landing/followescreen.dart';
import 'package:dakowa_app/screens/landing/followingscreen.dart';
import 'package:dakowa_app/screens/landing/settingsscreen.dart';
import 'package:dakowa_app/screens/search/searchscreen.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'createusernamemodal.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {



  List<Widget> _screens = [
    ExploreScreen(),
    FollowersScreen(),
    FollowingScreen(),
    //DashboardScreen(),
    SettingsScreen()
  ];

  int _screen = 0;

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'dakowa_rateMyApp_',
    minDays: 3,
    minLaunches: 10,
    remindDays: 5,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.steinacoz.dakowa_app',
    appStoreIdentifier: '1491556149',
  );

  openRateApp() async{
    await rateMyApp.init();
    if (rateMyApp.shouldOpenDialog) {
      rateMyApp.showRateDialog(
        context,
        title: 'Rate this app', // The dialog title.
        message: 'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.', // The dialog message.
        rateButton: 'RATE', // The dialog "rate" button text.
        noButton: 'NO THANKS', // The dialog "no" button text.
        laterButton: 'MAYBE LATER', // The dialog "later" button text.
        listener: (button) { // The button click listener (useful if you want to cancel the click event).
          switch(button) {
            case RateMyAppDialogButton.rate:
              print('Clicked on "Rate".');
              break;
            case RateMyAppDialogButton.later:
              print('Clicked on "Later".');
              break;
            case RateMyAppDialogButton.no:
              print('Clicked on "No".');
              break;
          }

          return true; // Return false if you want to cancel the click event.
        },
        ignoreNativeDialog: false,//Platform.isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
        dialogStyle: const DialogStyle(), // Custom dialog styles.
        onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
      );
    }
  }

  @override
  void initState(){
    FirebaseInAppMessaging.instance.setMessagesSuppressed(false);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
       initData()
    );
  }



  initData() async {

    openRateApp();
    await Provider.of<AuthProvider>(context, listen: false).retrieveUser();
    Provider.of<LandingProvider>(context, listen: false).userProfileExplore(Provider.of<AuthProvider>(context, listen: false).user!.id!);
    Provider.of<LandingProvider>(context, listen: false).userExplorePosts(Provider.of<AuthProvider>(context, listen: false).user!.id!);
    Provider.of<LandingProvider>(context, listen: false).userExplorePosts(Provider.of<AuthProvider>(context, listen: false).user!.id!);
    Provider.of<LandingProvider>(context, listen: false).exploreCreators("creator", Provider.of<AuthProvider>(context, listen: false).user!.id!);
    Provider.of<LandingProvider>(context, listen: false).userFollowers(Provider.of<AuthProvider>(context, listen: false).user!.id!);
    Provider.of<LandingProvider>(context, listen: false).userFollowing(Provider.of<AuthProvider>(context, listen: false).user!.id!);
    print(await FirebaseMessaging.instance.getToken());
    final dt = await FirebaseMessaging.instance.getToken();
    Provider.of<LandingProvider>(context, listen: false).updateDeviceToken(
        Provider.of<AuthProvider>(context, listen: false).user!.id!,
      dt!

    );
  }



  changeScreen(int scr){
    setState(() {
      _screen = scr;
    });
  }

  Widget _menuWidget(BuildContext context){
    //var aProvider = Provider.of<AuthProvider>(context, listen: false);
    return SizedBox(
      width: Get.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(

          decoration: BoxDecoration(
              color: mainColor,//Color(0xffc4c4c4),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
          child: Column(
            
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Icon(Icons.keyboard_arrow_up_rounded, color: Color(0xff43f6ea),)
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      changeScreen(0);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: _screen == 0 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.home_rounded, size: 20, color: Color(0xff43f6ea), )),
                  ),

                  InkWell(
                    onTap: (){
                      changeScreen(1);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: _screen  == 1 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.group_rounded, size: 20, color: Color(0xff43f6ea), )),
                  ),

                  InkWell(
                    onTap: () => changeScreen(2),
                    child: Container(
                        decoration: BoxDecoration(
                          color: _screen  == 2 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.emoji_people_rounded, size: 20, color: Color(0xff43f6ea),)),
                  ),

                  InkWell(
                    onTap: () {

                      var aProvider = Provider.of<AuthProvider>(context, listen: false);
                      if(aProvider.user!.username != null && aProvider.user!.username!.isNotEmpty){
                        Get.to(() => DashBoardScreen());
                      }else{
                        showDialog(
                            context: context,
                            builder: (_){
                              return CreateUserModal(ctx: context);
                            }
                        );
                      }

                    },
                    child: Icon(Icons.dashboard_outlined, color: Color(0xff43f6ea), size: 20,),
                  ),

                  InkWell(
                    onTap: (){
                     changeScreen(3);
                    },
                    child: Icon(Icons.settings, color: Color(0xff43f6ea)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _creatorsHolderMobileContainer(User cr){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: InkWell(
        onTap: (){
          var lp =  Provider.of<LandingProvider>(context, listen: false);
          lp.setSelectedFellowerId(cr);
          Get.to(() => FollowDetailScreen());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: "${cr.avatar}",
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                backgroundImage: imageProvider,
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: 5,),

            Text("${cr.username}", style: TextStyle(fontSize: 12, fontFamily: 'KiwiRegular'),)
          ],
        ),
      ),
    );
  }

  /// The widget builder.
  WidgetBuilder builder = buildProgressIndicator;

  /// Builds the progress indicator, allowing to wait for Rate my app to initialize.
  static Widget buildProgressIndicator(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset("assets/images/main_logo.png"),

          actions: [
            InkWell(
              onTap: (){
                Get.to(() => SearchScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.search_rounded, color: Colors.white, size: 24,),
              ),
            )
          ],
        ),
        body: ExpandableBottomSheet(
          background: _screens[_screen],
          persistentHeader: _menuWidget(context),
          expandableContent: Container(
            height: 500,
            width: Get.width,
            color: Colors.white,//Color(0xffc4c4c4),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
                      child: Text("Creators you might fancy", style: TextStyle( fontWeight: FontWeight.w900, color: Colors.black87, fontFamily: 'KiwiMedium', fontSize: 14),),
                    ),
                    SizedBox(height: 5,),
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      children: List.generate(Provider.of<LandingProvider>(context, listen: true).creators.length, (index) =>
                          _creatorsHolderMobileContainer(Provider.of<LandingProvider>(context, listen: true).creators[index])
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
       // bottomNavigationBar: ,
      )

    );
  }
}
