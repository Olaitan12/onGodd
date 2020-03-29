import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:secured_parking/models/app_state.dart'; 
import 'package:secured_parking/screens/main_tabs/capture.dart';
import 'package:secured_parking/screens/scan_screen.dart';
import 'package:secured_parking/styles/http.dart';

class ConfirmImage extends StatelessWidget {
  final String link;
  final String id;

  ConfirmImage({Key key, this.link, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  new StoreConnector<AppState, dynamic>(
      converter: (store) { 
            return {
        "company": store.state.auth.company,
        "id": store.state.auth.company['id'],
        "user": store.state.auth.user.id,
        "token": store.state.auth.user.token
      };
    }, builder: (BuildContext context, storex) {
      return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        height:110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color:  Colors.blue 
              ),
              padding: EdgeInsets.only(
                top: 5,
                left: 20,
                bottom: 5
              ),
              child: new Text(   "Please Select an Organization to work for!",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: new Text(
                "Please verify the value belongs to this owner",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            ),

            new ListTile(
              onTap: () async {
               
                    Map data  = { 
                      "id": id, 
                      "user": storex['user'],
                      "token": storex['token']
                    };
 
                    var response =
                        await postHttp(path: 'unlock', data: data);
                  
                    print(response);

                    if(response['status']){
                        alert("Confirmed!");
        Navigator.of(context)
                        .pushNamedAndRemoveUntil('/main', (_) => false);
                    }
              },
              // trailing: Icon(Icons.verified_user, color: Colors.blue),
              leading: Icon(Icons.verified_user, color: Colors.blue),
              title: new Text("Confirm Ownership!"),
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
            image: NetworkImage('http://api.securedparking.ng/public/images/$link'),
          ),
        ),
        height: MediaQuery.of(context).size.height,
      ),
      );
    }
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
