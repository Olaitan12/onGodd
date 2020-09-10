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
      return (BuildContext context, Map company) =>
          store.dispatch(selectUserCompany(context, company));
    }, builder: (BuildContext context, storex) {
      return Container(
        child: FutureBuilder(
          future: getHttp(path: 'getOrgs'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return body(snapshot.data, storex);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    });
  }

  Widget body(data, storex) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 35,
          ),
          Text('Select Company to Work for!', style: TextStyle(
            fontSize: 20,
          ),),
          Expanded(
              child: ListView.separated(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var org = data[index];
              final name = org['fullname'] ?? '';
              return ListTile(
                onTap: () {
                  print('clicked org');
                  storex(context, { "id": org['id'], "name": name});
                },
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text(
                  name.toUpperCase(),
                ),
                contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ))
        ],
      ),
    );
  }
}
