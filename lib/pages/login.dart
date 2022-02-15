// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
  bool loading = false;
  @override
  void initState() {
    setState(() {
      login.text = '1235';
      password.text = '7Eo7Pn';
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
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
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
                onTap: () {
                  if(loading) return;
                  HapticFeedback.lightImpact();
                  if(login.text.isEmpty || password.text.isEmpty) {
                    const snackBar = SnackBar(
                      backgroundColor: Colors.orange,
                      content: Text('Заполнены не все поля'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                  setState(() {
                    loading = true;
                  });
                  ApiClient().logIn(login.text.toString(), password.text, true, 'Санитар').then((value) async {
                    setState(() {
                      loading = false;
                    });
                    FocusScope.of(context).unfocus();
                    if(value == null || value['role'] != 'Санитар') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(value != null && value['role'] != 'Санитар' ? 'Доступ запрещен' : 'Ошибка, неверные данные.'),
                      ));
                      return;
                    }
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
                  child: loading ? SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ) : Text(
                    'Войти', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}