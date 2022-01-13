import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soto_project/pages/initPage.dart';
import 'package:soto_project/shared/api.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  @override
  void initState() {
    setState(() {
      password.text = 'qqq3qqqqqoopp123xqrrq';
    });
    _determinePosition().then((value) {
      print(value.toJson());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text('Авторизация', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30, fontFamily: 'San Francisco'),),
              )
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  CupertinoFormSection.insetGrouped(
                      header: const Text('Данные'),
                      children: [
                        CupertinoFormRow(
                          child: CupertinoTextFormFieldRow(
                            onChanged: (v) => setState(() {

                            }),
                            controller: login,
                            placeholder: 'Введите E-Mail',
                          ),
                          prefix: Text('E-Mail'),
                        ),
                        CupertinoFormRow(
                          child: CupertinoTextFormFieldRow(
                            obscureText: true,
                            onChanged: (v) => setState(() {

                            }),
                            controller: password,
                            placeholder: 'Введите пароль',
                          ),
                          prefix: Text('Пароль'),
                        )
                      ]
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CupertinoButton(
                      child: Text('Авторизоваться'),
                      color: CupertinoColors.activeBlue,
                      disabledColor: CupertinoColors.opaqueSeparator,
                      onPressed: login.text.isEmpty || password.text.isEmpty ? null : () {
                        ApiClient().logIn(login.text, password.text, true).then((value) {
                          if(value == null) {
                            const snackBar = SnackBar(
                              content: Text('Ошибка, неверные данные.'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                          };
                          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (ctx) => InitPage()),
                                  (route) => false);
                          const snackBar = SnackBar(
                            content: Text('Вы успешно авторизованы!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}