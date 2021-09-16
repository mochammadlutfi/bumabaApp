import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:global_configuration/global_configuration.dart';
import 'Config/app_theme.dart';
import 'Core/firebase.service.dart';
import 'route_generator.dart';
import 'Core/app_boot.dart' as setting;
import 'repository/user_repository.dart' as userRepo;
import 'repository/simla_repository.dart' as simlaRepo;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = (Platform.isAndroid || Platform.isIOS) ? FlutterLocalNotificationsPlugin() : null;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("configurations");
  await Firebase.initializeApp();
  await FirebaseService.setUpFirebaseMessaging();
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
      theme: AppTheme.lightTheme
    );
  }
}
