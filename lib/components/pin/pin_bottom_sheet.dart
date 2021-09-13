import 'package:bumaba/components/keyboard/keyboard_key_widget.dart';
import 'package:bumaba/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class SecurityPinBottomSheet extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  ValueSetter<String> onComplete = (value) {}; 

  SecurityPinBottomSheet({Key key, this.scaffoldKey, this.onComplete}) : super(key: key);

  @override
  _SecurityPinBottomSheetState createState() => _SecurityPinBottomSheetState();
}

class _SecurityPinBottomSheetState extends StateMVC<SecurityPinBottomSheet> {
  List<List<dynamic>> keys;
  String amount = '';
  TextEditingController pinController = new TextEditingController();

  // @override
  void initState() {
    super.initState();
    keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', Icon(Icons.keyboard_backspace, color: Colors.black,)],
    ];

    amount = '';
  }

  onKeyTap(val) {

    setState(() {
      // amount = 
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

  renderKeyboard() {
    return keys
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
                        onBackspacePress();
                      } else {
                        onKeyTap(val);
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
  
  renderConfirmButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: amount.length > 0 ? Colors.green : Colors.grey[200],
                  minimumSize: Size(100, 50),
              ),
              onPressed: amount.length > 0 ? (){
                // simpanTopUp();
              } : null,
              child: Text(
                  'Lanjutkan',
              style: TextStyle(
                color: amount.length > 0 ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
          ),
        ],
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(14), topLeft: Radius.circular(14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(24, 18, 24, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex : 8,
                  child : Text("Masukan Security PIN",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                        Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                ),
              ],
            )
          ),
          Container(
            padding: EdgeInsets.only(top: 0, right: 27, left: 27),
            alignment: Alignment.center,
            child : PinCodeTextField(
                controller : pinController,
                appContext: context,
                readOnly: true,
                enablePinAutofill : false,
                length: 6,
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
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (value) => widget.onComplete(value),
                onChanged: (value) { 
                },
              ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child : Container(
                width : MediaQuery.of(context).size.width,
                color : Theme.of(context).backgroundColor,
                margin: EdgeInsets.symmetric(vertical : 10),
                padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
                child: Column(
                  mainAxisAlignment : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...renderKeyboard(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
