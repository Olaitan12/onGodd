import 'package:dio/dio.dart';


String url = 'http://api.securedparking.ng/public/api';
 
getHttp({path}) async {
  try {
    Response response = await Dio().get("$url/$path");
    print('data request ${response.request}');
    print('data response $response');
    return response.data;
  } catch (e) {
    print(e);
  }
}
postHttp({ path, data}) async {
  try {
    print('data $data $url/$path');
    Response response = await Dio().post("$url/$path", data: data);
    print('data request ${response.request}');
    print('data response $response');
    return response.data;
  } catch (e) {
    print(e);
  }
}
 