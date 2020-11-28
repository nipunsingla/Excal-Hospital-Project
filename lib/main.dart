import 'package:HomeTreatment/provider/auth.dart';
import 'package:HomeTreatment/screens/LoginScreen.dart';
import 'package:HomeTreatment/screens/MainScreen.dart';
import 'package:HomeTreatment/screens/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import './screens/HomeScreen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

void main()async  {

WidgetsFlutterBinding.ensureInitialized();

 WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('app_logo');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider<Auth>(create: (_) => Auth())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

 


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Treatment',
      theme: ThemeData(
          backgroundColor: HexColor("#151515"),
          primaryColor: HexColor("#E50914"),
          splashColor: HexColor("#E50914"),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: Colors.white,
          textTheme: TextTheme(
              headline6:
                  TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              headline4:
                  TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              subtitle1:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        MainScreen.routeName:(context)=>MainScreen(),
      },
    );
  }
}
