import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:secured_parking/models/app_state.dart';
import 'package:secured_parking/screens/main_tabs/capture.dart';
import 'package:secured_parking/screens/main_tabs/confirm_image.dart';
import 'package:secured_parking/styles/http.dart';

class ScanScreen extends StatefulWidget {
  final String type;
  final image;

  ScanScreen({@required this.type, this.image});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    print('widget.type ${widget.type}');
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
              child: widget.type == 'capture'
                  ? customCaptureBarTypeCaputure(context, widget.image)
                  : customCaptureBarTypeScan(context),
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

  Widget customCaptureBarTypeCaputure(BuildContext context, image) {
    print('widget.type ${widget.type}');
    return new StoreConnector<AppState, dynamic>(converter: (store) {
      print(store.state.auth.company);
      print(store.state.auth);
      return {
        "company": store.state.auth.company,
        "id": store.state.auth.company['id'],
        "user": store.state.auth.user.id,
        "token": store.state.auth.user.token
      };
    }, builder: (BuildContext context, storex) {
      return storex['company'] == null
          ? Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.red),
              padding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              child: new Text(
                "Please Select an Organization to work for!",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
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
                  onPressed: () async {
                    print('qrText $qrText');
                    FormData formData = FormData.fromMap({
                      "qrcode": qrText,
                      "image": await MultipartFile.fromFile(image,
                          filename: image.split('/').last),
                      "organization": storex['id'],
                      "user": storex['user'],
                      "token": storex['token']
                    });

                    var response =
                        await postHttp(path: 'capture', data: formData);
                     

                    print(response);

                    if (response['status']) {
                      alert("Secured!");
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/main', (_) => false);
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
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
    });
  }

  Widget customCaptureBarTypeScan(BuildContext context) {
    print('widget.type ${widget.type}');
    return new StoreConnector<AppState, dynamic>(converter: (store) {
      print(store.state.auth.company);
      print(store.state.auth);
      return {
        "company": store.state.auth.company,
        "id": store.state.auth.company['id'],
        "user": store.state.auth.user.id,
        "token": store.state.auth.user.token
      };
    }, builder: (BuildContext context, storex) {
      return storex['company'] == null
          ? Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.red),
              padding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
              child: new Text(
                "Please Select an Organization to work for!",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.transparent,
                  onPressed: () async {
                    print('qrText $qrText');

                    Map data = {"qrcode": 'qrText', "token": storex['token']};

                    var response = await postHttp(path: 'scan', data: data);
                    
                    print(response);

                    if (response['status']) {
                      alert("Confirm Motor!");
                        String link = response['result']['image'];
                        List parts = link.split('/');  
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmImage(
                              link: parts[parts.length - 1],
                              id: response['result']['id']), //capture / scan
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
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
    });
  }
}
