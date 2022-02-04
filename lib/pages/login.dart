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
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Авторизация', style: TextStyle(fontSize: 17),),
      ),
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  CupertinoFormSection.insetGrouped(
                      header: const Text('Введите данные для входа'),
                      children: [
                        CupertinoFormRow(
                          child: CupertinoTextFormFieldRow(
                            onChanged: (v) => setState(() {

                            }),
                            controller: login,
                            placeholder: 'Введите номер',
                          ),
                          prefix: Text('Табельный номер'),
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
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CupertinoButton(
                              child: Text('Войти'),
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
                          ),
                        )
                      ],
                    ),
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