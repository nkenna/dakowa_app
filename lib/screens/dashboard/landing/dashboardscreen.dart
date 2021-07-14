import 'package:cached_network_image/cached_network_image.dart';
import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/screens/landing/exitmodal.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DashBoardProvider>(context, listen: false).setCurrentUser(
        Provider.of<AuthProvider>(context, listen: false).user!
    );
    Provider.of<DashBoardProvider>(context, listen: false).creatorProfile(Provider.of<DashBoardProvider>(context, listen: false).creator!.username!);
    Provider.of<DashBoardProvider>(context, listen: false).creatorSupports(Provider.of<DashBoardProvider>(context, listen: false).creator!.username!);
    Provider.of<DashBoardProvider>(context, listen: false).creatorGoals(Provider.of<DashBoardProvider>(context, listen: false).creator!.username!);
  }

  Widget _mainLayoutWidget(BuildContext context){
    return SizedBox(
      width: Get.width * 0.8,
      height: Get.height,
      child: Container(
          color: Color(0xfff5f8fa),
          child: Provider.of<DashBoardProvider>(context, listen: true).dashboardScreens[Provider.of<DashBoardProvider>(context, listen: true).currentScreen]
      ),
    );
  }

  Widget _drawerContainer(){
    return Container(
      width: Get.width * 0.8,
      color: mainColor,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CachedNetworkImage(
              imageUrl: "${Provider.of<DashBoardProvider>(context, listen: true).creator != null ? Provider.of<DashBoardProvider>(context, listen: true).creator!.avatar : ""}",
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,//NetworkImage
                radius: 50,
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),

          SizedBox(height: 20,),

          _menuItem("Home",
              Icon(Icons.home_filled, color: Colors.white,),
                  () {
                    Get.back();
                    Provider.of<DashBoardProvider>(context, listen: false).setCurrentScreen(0);
                  }
          ),

          _menuItem("Goals",
              Icon(Icons.workspaces_outline, color: Colors.white,),
                  () {
                    Get.back();
                Provider.of<DashBoardProvider>(context, listen: false).setCurrentScreen(1);
                //Provider.of<DashBoardProvider>(context, listen: false).setToggleDrawer(false);
              }
          ),

          _menuItem("Supporters",
              Icon(Icons.people, color: Colors.white,),
                  () {
                    Get.back();
                Provider.of<DashBoardProvider>(context, listen: false).setCurrentScreen(2);
                //Provider.of<DashBoardProvider>(context, listen: false).setToggleDrawer(false);
              }
          ),

          _menuItem("Supports",
              Icon(Icons.account_tree_rounded, color: Colors.white,),
                  () {
                    Get.back();
                Provider.of<DashBoardProvider>(context, listen: false).setCurrentScreen(3);
               // Provider.of<DashBoardProvider>(context, listen: false).setToggleDrawer(false);
              }
          ),

          _menuItem("Posts",
              Icon(Icons.post_add, color: Colors.white,),
                  () {
                    Get.back();
                Provider.of<DashBoardProvider>(context, listen: false).setCurrentScreen(4);
               // Provider.of<DashBoardProvider>(context, listen: false).setToggleDrawer(false);
              }
          ),

          _menuItem("Settings",
              Icon(Icons.settings, color: Colors.white,),
                  () {
                    Get.back();
                Provider.of<DashBoardProvider>(context, listen: false).setCurrentScreen(5);
               // Provider.of<DashBoardProvider>(context, listen: false).setToggleDrawer(false);
              }
          ),


          _menuItem("Logout",
              Icon(Icons.logout_rounded, color: Colors.white,),
                  (){
                    Get.back();
                //Provider.of<DashBoardProvider>(context, listen: false).setToggleDrawer(false);
                showDialog(
                    context: context,
                    builder: (context){
                      return ExitModal();
                    });
              }
          ),
        ],

      ),
    );
  }

  Widget _menuItem(String title, Widget icon, VoidCallback callback){
    return InkWell(

      onTap: callback,
      child: Container(
        width: double.infinity,
        //height: 60,
        decoration: BoxDecoration(

          color: Colors.transparent,
          //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10), )
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            SizedBox(width: 10,),
            Text(title, style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'KiwiRegular'),)
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: _drawerContainer(),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          color: Color(0xfff9f9f9),//Color(0xff0b6375),
          child: _mainLayoutWidget(context)
        ),
      ),
    );
  }
}
