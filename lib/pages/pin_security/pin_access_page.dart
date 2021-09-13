
import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Core/helper.dart';
import 'package:bumaba/components/keyboard/keyboard_key_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../controllers/pin_controller.dart';
import '../../Config/app.dart' as config;

class PinAccessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PinAccessPageState();
  }
}


class _PinAccessPageState extends StateMVC<PinAccessPage> {
  PinController _con;

  _PinAccessPageState() : super(PinController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }
renderKeyboard() {
    return _con.keys
        .map(
          (x) => Row(
            children: x.map(
              (y) {
                return Expanded(
                  child: KeyboardKeyWidget(
                    label: y,
                    value: y,
                    onTap: (val) {
                      if (val is Widget) {
                        _con.onBackspacePress();
                      } else {
                        _con.onKeyTap(val);
                      }
                    },
                  ),
                );
              },
            ).toList(),
          ),
        )
        .toList();
  }
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
      backgroundColor: Colors.white,
        key: _con.scaffoldKey,
        body: SafeArea(
          child: Column(
          children: <Widget>[
            Container(
                width: size.width,
                padding: EdgeInsets.fromLTRB(30,60,30,20),
                child: Column(
                  children: <Widget>[
                    Text("Masukan Security PIN",
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

            Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                padding: EdgeInsets.fromLTRB(20,0,20,20),
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      PinCodeTextField(
                        controller : _con.pinController,
                        appContext: context,
                        autoFocus: true,
                        enablePinAutofill : false,
                        length: 6,
                        showCursor: false,
                        readOnly: true,
                        obscureText: true,
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
                        onCompleted: (value) {
                          _con.accessApp(value, "login");
                        },
                        onChanged: (String value) { 

                        },
                      ),
                    ],
                  ),
              ),

            Container(
                child : Column(
                  children : [
                    ...renderKeyboard(),
                  ]
                )
              ),
          ],
        ),
        )
      ),
    );
  }
} 