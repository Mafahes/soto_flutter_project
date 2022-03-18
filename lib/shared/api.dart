import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as DioReq;
import 'package:soto_project/pages/login.dart';
import 'package:soto_project/shared/interface/Order.dart';
import 'package:soto_project/shared/interface/OrderById.dart';

import 'interface/Self.dart';
enum WorkStatus {
  onNotWork,
  onWork,
  onPause,
  onChange
}
enum OrderStatus {
  newOrder,
  notConfirmed,
  submitted,
  onPlace,
  onWayMorgue,
  morgueSubmitted,
  denided
}
class Prefs {
  static const API_URL = 'https://soto.3dcafe.ru/';
  static const orderStatuses = ["Новая", "Не подтверждена", "Принята", "Прибыл на место", "Следует в морг", "Сдал в морг", "Отклонена"];
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
class DioClient {
  Dio dio = Dio();
  Future<Dio> instance() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if(sp.get('token') != null) {
      dio.options.headers['Authorization'] = 'Bearer ${sp.get('token')}';
    }
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError resp) async {
        if(resp.response.statusCode == 401) {
          LocalService().delKey();
          try {
            Prefs.navigatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => LoginPage()), (route) => false);
          } catch(e) {
            print(e);
          }
        }
        return resp;
      },
        onResponse: (Response resp) async {
          if(resp.statusCode != 200) {
            print('ERRORRRRR');
          }
          return resp;
        }
    ));
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
  Future clear() async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.clear();
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
      await ApiClient().setStatus(WorkStatus.onWork, '');
      return resp.data;
    } catch(err) {
      print(err);
      return null;
    }
  }
  Future<String> loadFileViewer(String url) async {
    var perm = await Permission.storage.request();
    if(perm.isGranted) {
      var dio = await DioClient().instance();
      var dir = await getApplicationDocumentsDirectory();
      print("${dir.path}/${url.split('/').last}");
      Directory gbu = Directory('/storage/emulated/0/Download/GBU');
      if(await gbu.exists() == false) {
        await gbu.create();
      }
      var exists = await File("/storage/emulated/0/Download/GBU/${url.split('/').last}").exists();
      if(exists == true) {
        return "/storage/emulated/0/Download/GBU/${url.split('/').last}";
      }
      try {
        await dio.download(url, "/storage/emulated/0/Download/GBU/${url.split('/').last}");
        return "/storage/emulated/0/Download/GBU/${url.split('/').last}";
      } catch(e) {
        print('error');
        print(e);
        return '';
      }
    } else {
      print('not permitted');
      return '';
    }
  }
  Future<List<dynamic>> uploadFile(File file, [srcToken]) async {
    try {
      var dio = DioReq.Dio();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      dio.options.headers["authorization"] = 'Bearer ' + (srcToken == null ? token : srcToken);
      var form = DioReq.FormData.fromMap({
        "uploadedFiles": await DioReq.MultipartFile.fromFile(file.path)
      });
      var response = await dio.post(
          '${Prefs.API_URL}api/appfiles', data: form);
      print(response.data);
      return response.data;
    } catch(e, s) {
      print(e);
      return [];
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
  Future<List<Order>?> getNewOrders() async {
    Dio dio = await DioClient().instance();
    try {
      var response = await dio.get(
          '${Prefs.API_URL}api/Orders/new');
      return orderFromJson(jsonEncode(response.data));
    } catch(e, s) {
      print(e);
      return null;
    }
  }
  Future editOrder(data) async {
    Dio dio = await DioClient().instance();
    try {
      var response = await dio.put(
          '${Prefs.API_URL}api/Orders', data: data);
      return true;
    } catch(e, s) {
      print(e);
      return null;
    }
  }
  Future<List<Order>?> getActiveOrders() async {
    Dio dio = await DioClient().instance();
    try {
      var response = await dio.get(
          '${Prefs.API_URL}api/Orders/active');
      return orderFromJson(jsonEncode(response.data));
    } catch(e, s) {
      print(e);
      return null;
    }
  }
  Future<OrderById?> getOrderById(id) async {
    Dio dio = await DioClient().instance();
    try {
      var response = await dio.get(
          '${Prefs.API_URL}api/Orders/$id');
      return orderByIdFromJson(jsonEncode(response.data));
    } catch(e, s) {
      print(e);
      return null;
    }
  }
  Future setStatus(WorkStatus status, String cause) async {
    Dio dio = await DioClient().instance();
    try {
      var response = await dio.post(
          '${Prefs.API_URL}api/user/set-state?state=${status.index}&cause=$cause');
      return true;
    } catch(e, s) {
      return null;
    }
  }
}