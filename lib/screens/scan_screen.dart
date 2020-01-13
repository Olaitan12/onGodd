import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:secured_parking/screens/main_tabs/capture.dart';

class ScanScreen extends StatefulWidget {
  final String type;

  ScanScreen({@required this.type});

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
      body: Stack(
        children: <Widget>[
          QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderLength: 30,
                borderRadius: 10,
                borderWidth: 10,
                cutOutSize: 300,
              ),
              onQRViewCreated: _onQRviewcreate),
          Positioned(
            bottom: 50,
            child: new Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: new BorderRadius.all(Radius.circular(30.0)),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: widget.type == 'cature' ? customCaptureBarTypeCaputure(context) : customCaptureBarTypeScan(context),
            ),
          ),
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
      print('scanData $scanData');
      scanData != null
          ? Fluttertoast.showToast(
              msg: "${widget.type}ed!",
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0)
          : print('scanning qrText $scanData');
      setState(() {
        qrText = scanData;
      });
    });
  }

  Widget customCaptureBarTypeScan(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ 
        FlatButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.white,
          onPressed: () {
            print('qrText $qrText');
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: new Text(
              'Scan QR Code',
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
      ],
    );
  }

  Widget customCaptureBarTypeCaputure(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.transparent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraWidget(), //capture / scan
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
            child: new Text(
              'Capture!',
              style: TextStyle(fontSize: 15.0, color: Colors.black),
            ),
          ),
        ),
        FlatButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.white,
          onPressed: () {
            print('qrText $qrText');
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: new Text(
              'Scan QR Code',
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
      ],
    );
  }
}
