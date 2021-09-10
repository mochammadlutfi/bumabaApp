import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Main/main_app_bar.dart';
import 'package:bumaba/Modules/Simla/simla_controller.dart';
import 'package:bumaba/route_argument.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:pin_code_fields/pin_code_fields.dart';


// ignore: must_be_immutable
class SimlaPinPage extends StatefulWidget {
  RouteArgument routeArgument;
  SimlaPinPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _SimlaPinPageState createState() => _SimlaPinPageState();
}

class _SimlaPinPageState extends StateMVC<SimlaPinPage> with SingleTickerProviderStateMixin {
  SimlaController _con;

  _SimlaPinPageState() : super(SimlaController()) {
    _con = controller;                                                                                                                                          
  }
  // @override
  void initState() {
    _con.simla = widget.routeArgument.param;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _con.scaffoldKey,
      appBar: mainappbar("Masukan Security Code"),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(24, 40, 24, 20),
                child: Column(
                  children: <Widget>[
                    Text("Masukan Security PIN Kamu Saat Ini ",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(top: 0, right: 27, left: 27, bottom: 20),
                child: Form(
                  // key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      PinCodeTextField(
                        appContext: context,
                        autoFocus: true,
                        enablePinAutofill : false,
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          inactiveColor : mainColor,
                          selectedColor : mainColor,
                          activeFillColor : bgLight,
                          disabledColor : bgLight,
                          inactiveFillColor : bgLight,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                        ),
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (value){
                          _con.simla.user.securityCode = value;
                          _con.confirmTransfer();
                        },
                        onChanged: (value) { 

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}


