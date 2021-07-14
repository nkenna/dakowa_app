import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/screens/landing/exitmodal.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateOptions extends StatefulWidget {
  @override
  _UpdateOptionsState createState() => _UpdateOptionsState();
}

class _UpdateOptionsState extends State<UpdateOptions> {
  bool _acceptNotif = true;
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";

  AppUpdateInfo? _updateInfo;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        initData()
    );
  }

  initData () async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    setState(() {});
    await checkForUpdate();
   // setState(() {});
  }

  Future<void> checkForUpdate() async {

    InAppUpdate.checkForUpdate().then((info) {

      _updateInfo = info;
      if(_updateInfo?.updateAvailability == 1){
        print("entered here");
        InAppUpdate.performImmediateUpdate()
            .catchError((e) => print(e.toString()));
      }
      print(_updateInfo!.updateAvailability);
      print( UpdateAvailability.updateAvailable);


    }).catchError((e) {
      print(e);
    });
  }



  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : print( 'Could not launch $url');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: CheckboxListTile(
                value: _acceptNotif,
                selected: _acceptNotif,
                title: Text("Email Notification", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular'),),
                subtitle: Text("Check to receive Email Notifications", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular')),
                checkColor: mainColor,
                activeColor: Colors.green,
                onChanged: (value) async{
                  final resp = await Provider.of<LandingProvider>(context, listen: false).editEmailNotif(
                      Provider.of<AuthProvider>(context, listen: false).user!.id!,
                      value!
                  );
                  if(resp == true){
                    setState(() {
                      _acceptNotif = value;
                    });
                  }
                },
              )
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ListTile(
              onTap: (){
                _launchURL("https://dakowa.com/faq");
              },
              title: Text("FAQ", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular')),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ListTile(
              onTap: (){
                _launchURL("https://dakowa.com/privacy");
              },
              title: Text("Privacy Policy", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular')),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: ListTile(
              onTap: (){
                checkForUpdate();
              },
              title: Text("Check for new Version", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular')),
              trailing: Text("v${version}", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular')),
            ),
          ),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ListTile(
                title: Text("Logout", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular')),
                subtitle: Text("This operation will required you to login again when you comeback", style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'KiwiRegular')),
                onTap: (){
                  showDialog(context: context, builder: (context){
                    return ExitModal();
                  });
                },
              )
          ),


        ],
      ),
    );
  }
}
