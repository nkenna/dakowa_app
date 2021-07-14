import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/screens/dashboard/settings/editprofile/editprofile.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bankinfo/bankinfoscreen.dart';
import 'integration/integrationscreen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: TabBar(
              labelColor: Colors.black,
              labelStyle: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'KiwiMedium', fontWeight: FontWeight.w700),
              indicatorColor: mainColor,
              tabs: [
                Tab(text: "Bank Info"),
                Tab(text: "Integration"),
                Tab(text: "Edit Profile"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BankInfoScreen(),
              IntegrationScreen(),
              EditProfileScreen()
            ],
          ),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DashBoardProvider>(context, listen: false).dakowaBanks();
  }
}
