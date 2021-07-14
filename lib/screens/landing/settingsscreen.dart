import 'package:dakowa_app/screens/landing/updateoptions.dart';
import 'package:dakowa_app/screens/landing/updateprofile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Color(0xfff9f9f9),//Color(0xff0b6375),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              leading: Container(),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Options", icon: Icon(Icons.workspaces_outline )),
                  Tab(text: "Update Profile", icon: Icon(Icons.people)),

                ],
              ),
          //    title: Text('Settings'),
            ),
            body: TabBarView(
              children: [
                UpdateOptions(),
                UpdateProfile(),

              ],
            ),
          ),
        ),
      ),
    );


  }
}
