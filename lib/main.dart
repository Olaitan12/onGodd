import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'package:secured_parking/presentation/platform_adaptive.dart';
import 'package:secured_parking/screens/loading_screen.dart';
import 'package:secured_parking/screens/login_screen.dart';
import 'package:secured_parking/screens/main_screen.dart';
import 'package:secured_parking/store/store.dart';
import 'package:secured_parking/middleware/middleware.dart';
import 'package:secured_parking/models/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new ReduxApp());
}

class ReduxApp extends StatelessWidget {
  final store = createStore();

  ReduxApp();

  @override
  Widget build(BuildContext context) {
    return new PersistorGate(
      persistor: persistor,
      loading: new LoadingScreen(),
      builder: (context) => new StoreProvider<AppState>(
          store: store,
          child: new MaterialApp(
              title: 'ReduxApp',
              theme: defaultTargetPlatform == TargetPlatform.iOS
                  ? kIOSTheme
                  : kDefaultTheme,
              routes: <String, WidgetBuilder>{
                '/': (BuildContext context) =>
                    new StoreConnector<AppState, dynamic>(
                        converter: (store) => store.state.auth.isAuthenticated,
                        builder: (BuildContext context, isAuthenticated) =>
                            isAuthenticated
                                ? new MainScreen()
                                : new LoginScreen()),
                '/login': (BuildContext context) => new LoginScreen(),
                '/main': (BuildContext context) => new MainScreen()
              })),
    );
  }
}
