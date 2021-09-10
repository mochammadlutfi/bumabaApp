import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Main/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SimlaPinBottomSheet extends StatelessWidget {
  ValueSetter<String> onComplete = (value) {}; 

  SimlaPinBottomSheet({Key key, this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
        // child: ,
    //   );

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: new Container(
        alignment: Alignment.bottomCenter,
        child: Wrap(
          children: <Widget>[
            Container(
              height: 240,
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
                            onCompleted: (value) => onComplete(value),
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
          ],
        ), 
      ),
    );
  }
}
