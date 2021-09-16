
import 'package:bumaba/Core/helper.dart';
// ignore: unused_import
import 'package:bumaba/components/keyboard/keyboard_key_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/user_repository.dart' as userRepo;

class PinController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;
  bool hasError = false;
  OverlayEntry loader;
  List<List<dynamic>> keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['', '0', Icon(Icons.keyboard_backspace, color: Colors.black,)],
  ];
  TextEditingController pinController = new TextEditingController();

  PinController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    super.initState();
  }

  onKeyTap(val) {
    setState(() {
      pinController.text = pinController.text + val;
    });
  }

  onBackspacePress() {
    if (pinController.text.length == 0) {
      return;
    }

    setState(() {
      pinController.text = pinController.text.substring(0, pinController.text.length - 1);
    });
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
    hasError = false;
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
      if (loader != null) {
        loader.remove();
        loader = null;
      }
      setState(() { 
        hasError = true;
      });
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }


}
