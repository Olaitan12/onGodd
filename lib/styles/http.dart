import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


String url = 'http://api.securedparking.ng/public/api';
// String url = 'http://localhost:8000/api';
 
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
    alert('data response $response');
    return response.data;
    
  } catch (e) { 
    print('eoorror::  $e');
    alert('eoorror::  $e');
  }
}
alert(msg) {
      Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
}
 