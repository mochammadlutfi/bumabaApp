// import 'package:bumaba/Modules/Payment/payment_controller.dart';
// import 'package:bumaba/Modules/Payment/payment_model.dart';
// import 'package:bumaba/components/loading/loading_circular_widget.dart';
// import 'package:bumaba/route_argument.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';
// // ignore: unused_import
// import '../../../Config/color.dart';

// import '../Main/main_app_bar.dart';

// // ignore: must_be_immutable
// class PaymentProcessPage extends StatefulWidget {
//   RouteArgument routeArgument;

//   PaymentProcessPage({Key key, this.routeArgument}) : super(key: key);
//   @override
//   _PaymentProcessPageState createState() {
//     return _PaymentProcessPageState();
//   }
// }

// class _PaymentProcessPageState extends StateMVC<PaymentProcessPage> {
//   PaymentController _con;
//   Payment _payment = new Payment();

//   _PaymentProcessPageState() : super(PaymentController()) {
//     _con = controller;
//   }

//   @override
//   void initState() {
//     _payment = widget.routeArgument.param;
//     super.initState();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return new Scaffold(
//       key: _con.scaffoldKey,
//       appBar: mainappbar('Kirim Uang'),
//       body:  _con.payment == null ? CircularLoadingWidget(height: size.height) : 
//         SafeArea(
//           child: SingleChildScrollView(
//           child : Column(
//             children: [
//               Container(
//                 color: mainColor,
//                 padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
//                 width: size.width,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text("Kami sedang mengecek transaksi kamu",
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
//                     ),
//                     SizedBox(height: 16,),
//                     SvgPicture.asset(
//                       "assets/icons/document_search.svg",
//                       height: 70,
//                       color: Colors.white,
//                     ),
//                   ],
//                 )
//               ),
              
//               Container(
//                 color: Colors.white,
//                 margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                 width: size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(width: 1.5, color: bodylight),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "No Transaksi",
//                             style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
//                           ),
                          
//                           Text(
//                             '#' + _payment.noTransaksi,
//                             style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(width: 1.5, color: bodylight),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Metode Pembayaran",
//                             style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
//                           ),
                          
//                           Image.network(
//                               _payment.bankdetail.logo,
//                               height: 20,
//                           ),
//                         ],
//                       ),
//                     ),
                    
//                     Container(
//                       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(width: 1.5, color: bodylight),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Jumlah",
//                             style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
//                           ),
                          
//                           Text(
//                             NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(_payment.jumlah).toString(),
//                             style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(width: 1.5, color: bodylight),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Kode",
//                             style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
//                           ),
                          
//                           Text(
//                             _payment.kode.toString(),
//                             style: TextStyle(fontSize: 13, fontWeight : FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//             ],
//             // Image.asset(name)
//           ),
//         ),
//       ),
      
//     );
//   }
// }


