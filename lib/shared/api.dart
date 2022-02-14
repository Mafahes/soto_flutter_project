import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as DioReq;

import 'interface/Self.dart';
enum WorkStatus {
  onNotWork,
  onWork,
  onPause,
  onChange
}
class Prefs {
  static const API_URL = 'https://soto.3dcafe.ru/';
}
class DioClient {
  Dio dio = Dio();
  Future<Dio> instance() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(sp.get('token') != null) {
      dio.options.headers['Authorization'] = 'Bearer ${sp.get('token')}';
    }
    // dio.interceptors.add(InterceptorsWrapper(
    //     onResponse: (Response resp) async {
    //       print(resp.statusCode);
    //       return resp;
    //     }
    // ));
    return dio;
  }
}
class LocalService {
  Future setKey(String key) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('token', key);
      return true;
    } catch(err) {
      return false;
    }
  }
  Future getKey(String key) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.getString('token');
      return sp.getString('token');
    } catch(err) {
      return false;
    }
  }
  Future delKey() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.remove('token');
      return true;
    } catch(err) {
      return false;
    }
  }
}
class ApiClient {
  Future logIn(String login, String password, bool save, [String? role]) async {
    try {
      var a = {"login": login, "password": password};
      Response resp = await DioClient().dio.post('${Prefs.API_URL}Auth/Login',
          data: {"login": login, "password": password});
      if(role != null && role != resp.data['role']) return resp.data;
      await LocalService().setKey(resp.data['text']);
      var data = await OneSignal.shared.getDeviceState();
      print({
        "userId": data?.userId
      });
      await ApiClient().setPush(data?.userId ?? '', resp.data['text']);
      await ApiClient().setStatus(WorkStatus.onWork);
      return resp.data;
    } catch(err) {
      print(err);
      return null;
    }
  }
  Future<dynamic> setPush(String userId, String token) async {
    Dio dio = await DioClient().instance();
    try {
      dio.options.headers["authorization"] = 'Bearer ' + token;
      var response = await dio.get(
          '${Prefs.API_URL}api/users/pushChanel?pushChanel=$userId');
      return response.data;
    } catch(e, s) {
      print(e);
      return null;
    }
  }
  Future<dynamic> sendCoords(data) async {
    Dio dio = await DioClient().instance();
    var token = await LocalService().getKey('');
    try {
      var response = await dio.post(
          '${Prefs.API_URL}api/Positions', data: data);
      return response.data;
    } catch(e, s) {
      print(e);
      return null;
    }
  }
  Future<Self?> getSelf() async {
    Dio dio = await DioClient().instance();
    try {
      var response = await dio.get(
          '${Prefs.API_URL}api/user/0');
      return selfFromJson(jsonEncode(response.data));
    } catch(e, s) {
      print(e);
      return null;
    }
  }
  Future setStatus(WorkStatus status) async {
    Dio dio = await DioClient().instance();
    try {
      var response = await dio.post(
          '${Prefs.API_URL}api/user/set-state?state=${status.index}');
      return true;
    } catch(e, s) {
      return null;
    }
  }
}