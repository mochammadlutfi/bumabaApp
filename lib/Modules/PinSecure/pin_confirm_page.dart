
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Core/helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../route_argument.dart';
import 'pin_controller.dart';
import '../../Config/app.dart' as config;

// ignore: must_be_immutable
class PinConfirm extends StatefulWidget {
  RouteArgument routeArgument;

  PinConfirm({Key key, this.routeArgument}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PinConfirmState();
  }
}


class _PinConfirmState extends StateMVC<PinConfirm> {
  PinController _con;
  String errorPin = '';

  _PinConfirmState() : super(PinController()) {
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
                    Text("Konfirmasi Security PIN",
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      PinCodeTextField(
                        appContext: context,
                        autoFocus: true,
                        enablePinAutofill : false,
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        // validator: (String value) {
                        // },
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
                          if (value != widget.routeArgument.param) {
                            errorPin = "Security PIN Tidak Sama!";
                          }else {
                            errorPin = '';
                            _con.setupPin(value,"setup");
                          }
                            // print(widget.routeArgument.param);
                          // print(value);
                          // Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
                        },
                        onChanged: (value){
                          setState(() { 
                            // if(value.length < 6){
                              // errorPin = '';
                            // }
                          });
                        },
                      ),
                      Text(errorPin,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
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