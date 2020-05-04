import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secured_parking/screens/scan_screen.dart';
import 'package:secured_parking/styles/http.dart';

List<CameraDescription> cameras;

class CameraWidget extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<CameraWidget> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isReady = false;
  var theImage;

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      controller = new CameraController(cameras[0], ResolutionPreset.medium);
      await controller.initialize();
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
  }

  Widget build(BuildContext context) {
    if (!isReady) {
      return Container(
        child: Center(
          child: Image(image: AssetImage('assets/logo.png')),
        ),
      );
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: <Widget>[
            CameraPreview(controller),
            Positioned(
              top: 20,
              child: FlatButton(
                onPressed: () {
                  print('exit');
                  Navigator.pop(context);
                },
                child: Container(
                  child: new Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: 100,
            //   child: Center(
            //       child: Container(
            //         width: MediaQuery.of(context).size.width,
            //     padding: EdgeInsets.all(5),
            //     decoration: BoxDecoration(
            //       color: Colors.white70,
            //       borderRadius: new BorderRadius.all(Radius.circular(30.0)),
            //     ),
            //     child: new Text(
            //         'Cature Vehicle',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             fontSize: 25.0,
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             decoration: TextDecoration.none
            //             ),
            //       ),
            //     ),
            //   ),
            // ),

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
                child: customCaptureBar(context),
              ),
            ),
          ],
        ));
  }

  Widget customCaptureBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.white,
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await controller.initialize();

              // Construct the path where the image should be saved using the
              // pattern package.
              final path = join(
                // Store the picture in the temp directory.
                // Find the temp directory using the `path_provider` plugin.
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );

              // Attempt to take a picture and log where it's been saved.
              await controller.takePicture(path);
              setState(() {
                theImage = path;
              });
              print('path: $path');
              alert('image Captured');
                print(theImage);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanScreen(
                        type: "capture", image: theImage), //capture / scan
                  ),
                );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
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
          color: Colors.transparent,
          onPressed: () { 
            print(theImage);
            if(theImage != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanScreen(
                      type: "capture", image: theImage), //capture / scan
                ),
              );
            }else{
              alert('Please capture image');
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
            child: new Text(
              'Next >>> ',
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
