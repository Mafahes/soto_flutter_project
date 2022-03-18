// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soto_project/pages/login.dart';
import 'package:soto_project/pages/naryad/naryad.dart';
import 'package:soto_project/pages/order/order.dart';
import 'package:soto_project/pages/settings.dart';
import 'package:soto_project/shared/api.dart';

class InitPage extends StatefulWidget {
  InitPage({Key? key}) : super(key: key);

  @override
  _InitPageState createState() {
    return _InitPageState();
  }
}
enum GeoStatus {
  disabled,
  denided,
  permDenided
}
class _InitPageState extends State<InitPage> {
  var index = 0;
  Stream<Position> positionStream = Geolocator.getPositionStream(locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 30,
  ));
  bool geoFinished = true;
  bool geoPickerError = false;
  late Timer debouncer;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(GeoStatus.disabled);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return Future.error(GeoStatus.denided);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('deniedForever');
      return Future.error(GeoStatus.permDenided);
    }
    return Geolocator.getCurrentPosition();
  }
  geoPickerStart() {
    debouncer = Timer.periodic(Duration(seconds: 2), (timer) {
      if(geoFinished == false) return;
      setState(() {
        geoFinished = false;
      });
      _determinePosition().then((value) async {
        await ApiClient().sendCoords(value.toJson());
        setState(() {
          geoFinished = true;
          geoPickerError = false;
        });
      }).catchError((e) {
        debouncer.cancel();
        setState(() {
          geoPickerError = true;
          geoFinished = true;
        });
        Timer.run(() {
          showDialog(
              context: context, builder: (ctx) => AlertDialog(
            title: Text('Ошибка'),
            actions: [
              TextButton(
                child: Text('Разрешить'),
                onPressed: () {
                  geoPickerStart();
                  Navigator.of(ctx).pop();
                },
              ),
            ],
            content: Text(
                e == GeoStatus.denided ? 'Разрешите геолокацию' :
                e == GeoStatus.disabled ? 'Геологация отключена в настройках телефона' : 'Геолокация принудительно отключена настройками приложения'),
          )
          );
        });
      });
    });
  }
  @override
  void initState() {
    geoPickerStart();
    super.initState();
  }

  @override
  void dispose() {
    debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
              backgroundColor: Color(0xff2d2f33),
              bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: BottomNavigationBar(
                      currentIndex: index,
                      backgroundColor: Color(0xff2b2d31),
                      onTap: (i) {
                        setState(() {
                          index = i;
                        });
                      },
                      items: <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset('assets/menu/icon1.svg', width: 20, height: 20, color: index == 0 ? null : Colors.white,),
                            title: Text('Наряд', style: TextStyle(fontFamily: 'Lato', color: index == 0 ? null : Color(0xffDBDBDB)))
                        ),
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset('assets/menu/icon2.svg', width: 20, height: 20, color: index == 1 ? null : Colors.white,),
                            title: Text('Заявки', style: TextStyle(fontFamily: 'Lato', color: index == 1 ? null : Color(0xffDBDBDB)))
                        ),
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset('assets/menu/icon3.svg', width: 20, height: 20, color: index == 2 ? null : Colors.white,),
                            title: Text('Настройки', style: TextStyle(fontFamily: 'Lato', color: index == 2 ? null : Color(0xffDBDBDB)))
                        ),
                      ],
                    ),
                  )
              ),
            body: [NaryadPage(), OrderPage(), SettingsPage(
              onExit: () {
                debouncer.cancel();
                LocalService().clear().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => LoginPage()
                      ), (route) => false);
                });
              },
            )][index],
          ),
          !geoPickerError ? Container() : GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              geoPickerStart();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 60,
              width: double.infinity,
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Геолокация отключена', style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}