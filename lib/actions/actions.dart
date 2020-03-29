import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

import 'package:secured_parking/models/user.dart';
import 'package:secured_parking/models/app_state.dart';
import 'package:secured_parking/styles/http.dart';

class UserLoginRequest {}

class UserLoginSuccess {
  final User user;

  UserLoginSuccess(this.user);
}

class SelectOrganization {
  final Map company;

  SelectOrganization(this.company);
}

class UserLoginFailure {
  final String error;

  UserLoginFailure(this.error);
}

class UserLogout {}

final Function login =
    (BuildContext context, String username, String password) {
  return (Store<AppState> store) async {
    var response = await postHttp(
        path: 'login', data: {"email": username, "password": password});

    if (response['status']) {
      store.dispatch(new UserLoginSuccess(new User(response['token'],
          response['details']['id'], response['details']['email'])));
      Navigator.of(context).pushNamedAndRemoveUntil('/main', (_) => false);
    } else {
      store.dispatch(
          new UserLoginFailure('Username or password were incorrect.'));
    }
  };
};
final Function selectUserCompany = (BuildContext context, Map company) {
  return (Store<AppState> store) async {
    print('company $company');
    store.dispatch(new SelectOrganization(company));
    Fluttertoast.showToast(
        msg: "Company selection successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
    return Navigator.of(context).pushNamedAndRemoveUntil('/main', (_) => false);
  };
};

final Function logout = (BuildContext context) {
  return (Store<AppState> store) {
    store.dispatch(new UserLogout());
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
  };
};
// final Function logout = (BuildContext context) {
//     return (Store<AppState> store) {
//         store.dispatch(new UserLogout());
//         Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
//     };
// };
