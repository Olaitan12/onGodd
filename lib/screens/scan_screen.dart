import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
              child: QRView(
                  key: qrKey, 
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderLength: 30,
                    borderRadius: 10,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                  onQRViewCreated: _onQRviewcreate)),
          Expanded(
            flex: 1,
              child: Center(
            child: Text('Scan Result: $qrText'),
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRviewcreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }
}
