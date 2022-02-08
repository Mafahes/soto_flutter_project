// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return true ? Scaffold(
      backgroundColor: Color(0xff2d3034),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 25, right: 25, top: 25),
              child: Row(
                children: [
                  Image.asset('assets/logo.png'),
                  const SizedBox(width: 20),
                  const Flexible(
                    child: Text(
                        'Государственное Бюджетное Учреждение города Москвы Ритуал',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Lato'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50,),
            const Text('Авторизация', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            const Text('Введите данные для входа', style: TextStyle(color: Color(0xff7F8489), fontFamily: 'Lato', fontSize: 16)),
            const SizedBox(height: 60),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.only(bottom: 22),
              child: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (v) {
                  setState(() {

                  });
                },
                controller: login,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2b2f34)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2b2f34)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2b2f34)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Color(0xff7F8489)),
                    hintText: "Табельный номер",
                    fillColor: Color(0xff22252A).withOpacity(0.2)
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.only(bottom: 22),
              child: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (v) {
                  setState(() {

                  });
                },
                controller: password,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2b2f34)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2b2f34)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff2b2f34)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Color(0xff7F8489)),
                    hintText: "Пароль",
                    fillColor: Color(0xff22252A).withOpacity(0.2)
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
                onTap: login.text.isEmpty || password.text.isEmpty ? null : () {
                  HapticFeedback.lightImpact();
                  ApiClient().logIn(login.text.toString(), password.text, true).then((value) {
                    FocusScope.of(context).unfocus();
                    print(value);
                    if(value == null) {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.red,
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
                },
              child: Container(
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 50),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 4,
                      color: Color.fromRGBO(31,36,39,0.4)
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff6B5AD0),
                      Color(0xff5e3bc0),
                      Color(0xff451C9C)
                    ]
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 17),
                child: Center(
                  child: Text(
                    'Войти', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
                ),
              ),
            )
          ],
        ),
      ),
    ) : CupertinoPageScaffold(
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