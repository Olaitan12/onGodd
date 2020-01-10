import 'package:redux/redux.dart';

import 'package:secured_parking/reducers/app_reducer.dart';
import 'package:secured_parking/models/app_state.dart';
import 'package:secured_parking/middleware/middleware.dart';

Store<AppState> createStore() { 
    Store<AppState> store = new Store(
        appReducer,
        initialState: new AppState(),
        middleware: createMiddleware(),
    );
    persistor.start(store);

    return store;
}