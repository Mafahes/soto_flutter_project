import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    //       if(resp.statusCode == 500) {
    //         await dio.post('${Prefs.API_URL}api/users/logs/add?log=CODE_${resp.statusCode}_${resp.request.path.replaceAll('https://nomenclature.3dcafe.ru/', '')}__TOKEN_${resp?.request?.headers['Authorization'] != null ? resp?.request?.headers['Authorization'].replaceAll('Bearer ', '') : ''}');
    //       }
    //       return resp;
    //     }
    // ));
    // print(dio.options.headers);
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
  Future logIn(String login, String password, bool save) async {
    try {
      var a = {"login": login, "password": password};
      Response resp = await DioClient().dio.post('${Prefs.API_URL}Auth/Login',
          data: {"login": login, "password": password});
      LocalService().setKey(resp.data['text']);
      return resp.data;
    } catch(err) {
      print(err);
      return null;
    }
  }
}