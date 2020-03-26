import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:secured_parking/actions/actions.dart';
import 'package:secured_parking/models/app_state.dart';
import 'package:secured_parking/models/user.dart';
import 'package:secured_parking/styles/http.dart';

class StatsTab extends StatelessWidget {
  StatsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, dynamic>(converter: (store) {
      print('my store ${store.state}');
      return store.state.auth.user.token;
    }, builder: (BuildContext context, token) {
      return Container(
        child: FutureBuilder(
          future: getHttp(path: 'getOrgs'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return body(snapshot.data);
            }
            return CircularProgressIndicator();
          },
        ),
      );
    });
  }

  Widget body(data) {
    return Container(
      child: Column(
        children: <Widget>[
        Text('Select Company to Work for!'),
         Expanded(child: ListView.separated(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var org = data[index];
              return ListTile(
                onTap: (){
                  selectUserCompany(context, org['id']);
                },
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text(
                  org['fullname'].toUpperCase(),
                  
                ),
                contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          )
         )
        ],
      ),
    );
  }
}
