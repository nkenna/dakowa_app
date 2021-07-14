import 'dart:io';

import 'package:dakowa_app/providers/authprovider.dart';
import 'package:dakowa_app/providers/dashboardprovider.dart';
import 'package:dakowa_app/providers/landingprovider.dart';
import 'package:dakowa_app/providers/searchprovider.dart';
import 'package:dakowa_app/providers/supportprovider.dart';
import 'package:dakowa_app/screens/auth/loginscreen.dart';
import 'package:dakowa_app/screens/auth/splashscreen.dart';
import 'package:dakowa_app/utils/projectcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rate_my_app/rate_my_app.dart';

final ThemeData kDefaultTheme = new ThemeData(
    primarySwatch: materialMainColor,
    primaryColor: mainColor,
    accentColor: mainColor,
    primaryIconTheme: IconThemeData(color: Colors.white),
    primaryColorBrightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'KiwiRegular'

);

final ThemeData kIOSTheme = new ThemeData(
    primarySwatch: materialMainColor,
    primaryColor: mainColor,
    primaryIconTheme: IconThemeData(color: Colors.white),
    primaryColorBrightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'KiwiRegular'

);

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;




void configLoading() {
  EasyLoading.instance

    ..maskType = EasyLoadingMaskType.custom
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.rotatingPlain
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = mainColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
late final FirebaseMessaging _messaging;

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.data}");
}

void configurePN() async {
  // 1. Initialize the Firebase app
  await Firebase.initializeApp();

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'dakowa_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
  }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    print(await _messaging.getToken());


    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(message.notification!.body);
        RemoteNotification notification = message.notification!;
        AndroidNotification android = message.notification!.android!;
        if (notification != null && android != null && !kIsWeb) {
          flutterLocalNotificationsPlugin!.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel!.id,
                  channel!.name,
                  channel!.description,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: 'ic_notif',
                ),
              ));
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  configurePN();
  configLoading();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: mainColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: mainColor,
      )
  );
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider.value(value: AuthProvider.init()),
        ChangeNotifierProvider.value(value: LandingProvider.init()),
        ChangeNotifierProvider.value(value: DashBoardProvider.init()),
        ChangeNotifierProvider.value(value: SearchProvider.init()),
        ChangeNotifierProvider.value(value: SupportProvider.init()),

      ],
        child: MyApp(),
      )
  );
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dakowa',
      theme: Platform.isIOS ? kIOSTheme : kDefaultTheme,
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}


