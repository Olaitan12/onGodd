import 'package:flutter/material.dart';

import 'package:secured_parking/styles/colors.dart';

class LoadingScreen extends StatelessWidget {
    
    LoadingScreen({Key key}): super(key: key);

    @override
    Widget build(BuildContext context) {
        return new MaterialApp(
            home: new Scaffold(
                body: new Container( 
               
                  child:new Center(
                    child: Image(image: AssetImage('assets/logo.png'), 
                    ),
                ),
                ),
            ),
        );
    }

}