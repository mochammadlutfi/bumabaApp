
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Core/helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../route_argument.dart';
import '../../controllers/pin_controller.dart';
import '../../Config/app.dart' as config;

class PinSetupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PinSetupPageState();
  }
}


class _PinSetupPageState extends StateMVC<PinSetupPage> {
  PinController _con;

  _PinSetupPageState() : super(PinController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/img/bg/main_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/img/bg/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),

            Positioned(
              top: config.App(context).appHeight(30) - 20,
              child: Container(
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 17),
                child: Column(
                  children: <Widget>[
                    Text("Buat Security PIN",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(height: 6,),
                    Text("Security PIN digunakan untuk masuk ke akun kamu dan bertransaksi", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: greytext
                      ),
                    ),
                  ],
                )
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(30) - 20,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                padding: EdgeInsets.only(top: 0, right: 27, left: 27, bottom: 20),
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(40),
                child: Form(
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
                          // activeFillColor:
                              // hasError ? Colors.blue.shade100 : Colors.white,
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
                        onCompleted: (value) {
                          Navigator.of(context).pushNamed('/PinConfirm', arguments: new RouteArgument(param: value));
                        }, onChanged: (String value) {  },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 