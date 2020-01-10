import 'package:redux_persist/redux_persist.dart';

import 'package:secured_parking/models/app_state.dart';
import 'package:secured_parking/reducers/auth_reducer.dart';

AppState appReducer(AppState state, action){
    //print(action);
    if (action is PersistLoadedAction<AppState>) {
        return action.state ?? state;
    } else {
        return new AppState(
            auth: authReducer(state.auth, action),
        );
    }
} 