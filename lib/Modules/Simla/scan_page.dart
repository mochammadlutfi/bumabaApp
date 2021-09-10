import 'dart:io';

import 'package:bumaba/Config/color.dart';
import 'package:bumaba/Modules/Simla/simla_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'components/scanner.dart';
class SimlaScanPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SimlaScanPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SimlaScanPageState();
}

class _SimlaScanPageState extends StateMVC<SimlaScanPage> with SingleTickerProviderStateMixin {
  
  // ignore: unused_field
  SimlaController _con;
  AnimationController _animationController;
  bool scanning = true;
  Barcode result;
  QRViewController qrcontroller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  _SimlaScanPageState() : super(SimlaController()) {
    _con = controller;                                                                                                                                          
  }


  @override
  void initState() {
    _animationController = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);
      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animateScanAnimation(true);
        } else if (status == AnimationStatus.dismissed) {
          animateScanAnimation(false);
        }
      }
    );
    
      _animationController.forward(from: 0.0);
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrcontroller.pauseCamera();
    }
    qrcontroller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: _buildQrView(context),
          ),
          Positioned(
            child: AppBar(
                leading: BackButton(
                  color: Colors.white
                ), 
                backgroundColor: Colors.transparent,
                title: Text("Scan untuk membayar", style: TextStyle(color: Colors.white)),
                centerTitle: true,
              ),
          ),
          ImageScannerAnimation(
            size.width,
            animation: _animationController,
          ),
          Positioned(
            top: size.height * 0.65,
            child: Container(
              width: size.width,
              padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Arahkan kameramu sampai memuat seluruh kode QR untuk memulai Scan",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: new Radius.circular(19),
                  topRight: new Radius.circular(19)
                )
              ),
              height: MediaQuery.of(context).size.height * 0.23,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: size.width,
                        child: (result != null)
                          ? Text(
                              'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
                          : Text('Scan a code'),
                        padding: EdgeInsets.all(12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }


  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: 
      QrScannerOverlayShape(
          borderColor: mainColor,
          borderRadius: 10,
          // borderLength: 30,
          borderWidth: 10,
      ),
      // QrScannerOverlayShape(
      //   borderColor: mainColor,
      //   borderRadius: 10,
      //   // borderLength: 30,
      //   borderWidth: 10,
      // ),
    );
  }

  void _onQRViewCreated(QRViewController qrcontroller) {
    setState(() {
      this.qrcontroller = qrcontroller;
    });
    qrcontroller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        print(result.format);
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    qrcontroller?.dispose();
    super.dispose();
  }
}