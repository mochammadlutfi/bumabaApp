
import 'package:bumaba/Core/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// import '../../Core/custom_trace.dart';
// import '../Repository/SettingRepository.dart' as settingRepo;
import '../User/user_repository.dart' as userRepo;

class PinController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;
  String pinfirst = '';
  OverlayEntry loader;

  PinController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    super.initState();
  }

  void setupPin(String pin, String type) async {
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    Overlay.of(state.context).insert(loader);
      userRepo.setupPIN(pin).then((value) {
        if (value != null) {
          if(type == "setup"){
            Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
          }else if(type == "change"){
            Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 3);
          }

        }else {
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Koneksi Error!"),
          ));
        }
      }).catchError((e) {
        print(e);
        loader.remove();
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Opps !"),
          ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
  }


  void accessApp(String pin, String type) async {
    loader = Helper.overlayLoader(state.context);
    FocusScope.of(state.context).unfocus();
    Overlay.of(state.context).insert(loader);
      userRepo.accessPIN(pin).then((value) {
        if (value) {
          if(type == 'login'){
            Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 0);
          }else if(type == 'change'){
            Navigator.of(scaffoldKey.currentContext).pushNamed('/PinChangeSetup');
          }else{
            Navigator.pop(scaffoldKey.currentContext);
          }
        }else {
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Koneksi Error!"),
          ));
        }
      }).catchError((e) {
        print(e);
        loader.remove();
          ScaffoldMessenger.of(scaffoldKey?.currentContext).showSnackBar(SnackBar(
            content: Text("Opps !"),
          ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
  }


}
