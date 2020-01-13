import 'package:flutter/material.dart';
import 'package:secured_parking/screens/capture.dart';
import 'package:secured_parking/screens/main_tabs/capture.dart';
import 'package:secured_parking/screens/scan_screen.dart';

class NewsTab extends StatelessWidget {
  NewsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        height:170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: new Text(
                "Capture > Scan > Verify",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
            new SizedBox(
              height: 5.0,
            ),
            Divider(),
            new ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraWidget()),
                );
              },
              leading: Icon(Icons.camera_enhance, color: Colors.blue),
              title: new Text("Capture and Secure object!"),
            ),
            new ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScanScreen(type: 'scan',)),//capture / scan
                );
              },
              // trailing: Icon(Icons.verified_user, color: Colors.blue),
              leading: Icon(Icons.verified_user, color: Colors.blue),
              title: new Text("Verify QR Code!"),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.66), BlendMode.darken),
            fit: BoxFit.cover,
            image: AssetImage('assets/logo.png'),
          ),
        ),
        height: MediaQuery.of(context).size.height,
        // child: new Center(
        //   child: new Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        //     child: new Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[
        //         new SizedBox(
        //           height: 30.0,
        //         ),
        //         // new Text(
        //         //   'Lorem ipsum dolor sit, elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
        //         //   style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0),
        //         //   textAlign: TextAlign.justify,
        //         // ),
        //         new SizedBox(
        //           height: 30.0,
        //         ),
        //         new Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: <Widget>[
        //             customCard(context,
        //                 icon: Icons.camera_enhance,
        //                 title: "Capture",
        //                 place: ScanScreen()),
        //             customCard(context,
        //                 icon: Icons.verified_user,
        //                 title: "Verify",
        //                 place: CameraWidget()),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget customCard(
    context, {
    String title,
    IconData icon,
    Widget place,
  }) {
    return GestureDetector(
      onTap: () {
        print('user deserves to move to $title');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => place),
        );
      },
      child: Card(
        child: new Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
          child: Column(
            children: <Widget>[
              new Icon(
                icon,
                size: 50.0,
              ),
              new SizedBox(
                height: 10.0,
              ),
              new Text(
                "$title",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
