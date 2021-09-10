import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:global_configuration/global_configuration.dart';
import 'Core/firebase.service.dart';
import 'route_generator.dart';
import 'Config/app.dart' as config;
import 'Core/app_boot.dart' as setting;
import 'Config/color.dart';
import 'Modules/User/user_repository.dart' as userRepo;
import 'Modules/Simla/simla_repository.dart' as simlaRepo;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = (Platform.isAndroid || Platform.isIOS) ? FlutterLocalNotificationsPlugin() : null;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  await Firebase.initializeApp();
  await FirebaseService.setUpFirebaseMessaging();
  // print(token);
  // WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting('id_ID', null).then((_) => 
  // runApp(MyApp()));
  runApp(MyApp());
}
      

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    userRepo.getCurrentUser();
    simlaRepo.getCurrentSaldo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: setting.navigatorKey,
      title: 'Koperasi BUMABA',
      initialRoute: '/Splash',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
              backgroundColor: Color(0xFFF4F4F4),
              appBarTheme: AppBarTheme(color: mainColor, elevation: 0),
              fontFamily: 'Nunito Sans',
              primaryColor: Colors.white,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: mainColor,
                  elevation: 0,
                  splashColor: Colors.transparent
              ),
              accentColor: mainColor,
              dividerColor: config.Colors().accentColor(0.1),
              focusColor: config.Colors().accentColor(1),
              hintColor: config.Colors().secondColor(1),
              textTheme: TextTheme(
                headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: blacktext, height: 1.3),
                headline4: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: blacktext, height: 1.3),
                headline3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: blacktext, height: 1.3),
                headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: blacktext, height: 1.4),
                headline1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: blacktext, height: 1.4),
                subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: blacktext, height: 1.3),
                headline6: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: blacktext, height: 1.3),
                bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: blacktext, height: 1.2),
                bodyText1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: blacktext, height: 1.3),
                caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: config.Colors().accentColor(1), height: 1.2),
              ),
              
            )
    );
  }
}
