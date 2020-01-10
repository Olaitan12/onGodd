import 'package:flutter/material.dart';

class StatsTab extends StatelessWidget {
    StatsTab({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("data"),
              ),
              ListTile(
                title: Text("data"),
              ),
              ListTile(
                title: Text("data"),
              ),
            ],
          ),
        );
    }

}