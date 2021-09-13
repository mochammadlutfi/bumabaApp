// import 'package:bumaba/Config/color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:numeric_keyboard/numeric_keyboard.dart';

// class SimlaPinBottomSheet extends StatelessWidget {
//   final ValueSetter<String> onComplete;
//   String text;
//   SimlaPinBottomSheet({Key key, this.onComplete, this.text}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 600,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(color: Theme.of(context).primaryColor),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Text('Enter 6 digits verification code sent to your number', style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w500))
//                         ),
//                         Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               otpNumberWidget(0),
//                               otpNumberWidget(1),
//                               otpNumberWidget(2),
//                               otpNumberWidget(3),
//                               otpNumberWidget(4),
//                               otpNumberWidget(5),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   NumericKeyboard(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     onKeyboardTap: onComplete,
//                     textColor: blacktext,
//                     rightIcon: Icon(
//                       Icons.backspace,
//                       color: blacktext,
//                     ),
//                     rightButtonFn: () {
//                       // setState(() {
//                         text = text.substring(0, text.length - 1);
//                       // });
//                     },
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//     );
//   }

//   Widget otpNumberWidget(int position) {
//     try {
//       return Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 0),
//             borderRadius: const BorderRadius.all(Radius.circular(8))
//         ),
//         child: Center(child: Text(text[position], style: TextStyle(color: Colors.black),)),
//       );
//     } catch (e) {
//       return Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 0),
//             borderRadius: const BorderRadius.all(Radius.circular(8))
//         ),
//       );
//     }
//   }
  
//   // ignore: unused_element
//   void _onKeyboardTap(String value) {
//     text = text + value;
//   }
// }
