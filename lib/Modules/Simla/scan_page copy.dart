import 'dart:io';

import 'package:bumaba/Config/color.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class SimlaScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SimlaScanPageState();
}

class _SimlaScanPageState extends State<SimlaScanPage> {
  Barcode result;
  QRViewController qrcontroller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
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
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          Align(alignment: Alignment.center,
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
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: mainColor),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.flash_on),
                      ),
                      Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: mainColor),
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.check, color: Colors.white),
                      ),
                      Container(
                        child: FutureBuilder(
                          future: qrcontroller?.getCameraInfo(),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return Text('Putar Camera');
                            } else {
                              return Text('loading');
                            }
                          },
                        ),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        padding: EdgeInsets.all(12),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: mainColor,
        borderRadius: 10,
        // borderLength: 30,
        borderWidth: 10,
      ),
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
    qrcontroller?.dispose();
    super.dispose();
  }
}