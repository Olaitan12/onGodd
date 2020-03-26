import 'package:flutter/material.dart';

import 'package:secured_parking/containers/login_form.dart';
import 'package:secured_parking/styles/colors.dart';

class LoginScreen extends StatelessWidget {
    LoginScreen({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            body: new Container(
                child: new Padding(
                    padding: new EdgeInsets.fromLTRB(32.0, MediaQuery.of(context).padding.top + 32.0, 32.0, 32.0),
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            new Expanded(
                                child: new Center(
                                    child: Image(image: AssetImage('assets/logo.png'),
                                    )
                                ),
                            ),
                            new LoginForm()
                        ],
                    )
                )
            )
        );
    }

}