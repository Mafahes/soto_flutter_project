// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soto_project/shared/api.dart';
import 'package:soto_project/shared/interface/Order.dart';
import 'package:soto_project/shared/interface/Self.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, required this.onExit}) : super(key: key);
  VoidCallback onExit;
  @override
  _SettingsPageState createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  Self? user;
  bool loading1 = false;
  bool loading2 = false;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Конец смены"),value: "Конец смены"),
      DropdownMenuItem(child: Text("Поломка автомобиля"),value: "Поломка автомобиля"),
      DropdownMenuItem(child: Text("Тех. Обслуживание"),value: "Тех. Обслуживание"),
      DropdownMenuItem(child: Text("Перерыв"),value: "Перерыв")
    ];
    return menuItems;
  }
  @override
  parseData() {
    ApiClient().getSelf().then((value) {
      setState(() {
        user = value;
        loading1 = false;
        loading2 = false;
      });
    });
  }
  void initState() {
    parseData();
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
      backgroundColor: Color(0xff2c2e33),
      body: user == null ? Center(
        child: CircularProgressIndicator(),
      ) : SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Image.asset('assets/logo.png'),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Настройки', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                        SizedBox(height: 4),
                        Text(' (v1.7)', style: TextStyle(color: Colors.grey, fontSize: 8),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SettingContainer(user?.secondName ?? '-'),
                    SettingContainer(user?.firstName ?? '-'),
                    SettingContainer(user?.patronymic ?? '-'),
                    SettingContainer(user?.roleName ?? '-'),
                    SettingContainer('Табельный номер №${user?.inits ?? '-'}'),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        if(loading1) return;
                        HapticFeedback.lightImpact();
                        setState(() {
                          loading1 = true;
                        });
                        if(user?.state != 2) {
                          String selectedValue = 'Конец смены';
                          var submitted = await showDialog(
                              context: context,
                              builder: (ctx) => StatefulBuilder(
                                builder: (ctx, setState) {
                                  return Dialog(
                                    child: Container(
                                      height: 300,
                                      padding: EdgeInsets.all(30),
                                      child: Column(
                                        children: [
                                          Text('Укажите причину', style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Lato')),
                                          SizedBox(
                                              height: 40
                                          ),
                                          DropdownButton(
                                            value: selectedValue,
                                            items: dropdownItems,
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedValue = value ?? '';
                                              });
                                            },
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(selectedValue);
                                                  },
                                                  child: Text('Принять')
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                          );
                          if(submitted == null) {
                            setState(() {
                              loading1 = false;
                            });
                            return;
                          }
                          ApiClient().setStatus(user?.state == 2 ? WorkStatus.onWork : WorkStatus.onPause, selectedValue).then((value) {
                            parseData();
                          });
                          return;
                        }
                        ApiClient().setStatus(user?.state == 2 ? WorkStatus.onWork : WorkStatus.onPause, '').then((value) {
                          parseData();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
                        margin: EdgeInsets.only(bottom: 11),
                        decoration: BoxDecoration(
                            color: Color(0xff2c2e33),
                            border: Border.all(color: Color(0xffFD6B81), width: 2),
                            borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(4, 4),
                              spreadRadius: 7,
                              blurRadius: 7,
                              color: Color.fromRGBO(31, 36, 39, 0.6)
                            )
                          ]
                        ),
                        child: Center(
                          child: Text(loading1 ? 'Загрузка..' : user?.state == 2 ? 'Возобновить' : 'Завершить смену', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(loading2) return;
                        HapticFeedback.lightImpact();
                        setState(() {
                          loading2 = true;
                        });
                        List<Order>? orders1 = [];
                        List<Order>? orders2 = [];
                        try {
                          orders1 = await ApiClient().getNewOrders();
                          orders2 = (await ApiClient().getActiveOrders())?.where((element) => element.state == 0 || element.state == 1).toList();
                        } catch(e) {
                          orders1 = [];
                          orders2 = [];
                        }
                        if((orders1?.isNotEmpty ?? true) || (orders2?.isNotEmpty ?? true)) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Ошибка'),
                                content: Text('Завершите все активные заявки'),
                              )
                          );
                          setState(() {
                            loading2 = false;
                          });
                          return;
                        }
                        ApiClient().setStatus(WorkStatus.onNotWork, '').then((value) {
                          widget.onExit();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
                        margin: EdgeInsets.only(bottom: 22),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xffFF5574),
                                Color(0xffE9454F),
                                Color(0xffDC2450)
                              ]
                            ),
                            border: Border.all(color: Color(0xffFD6B81), width: 2),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(4, 4),
                                  spreadRadius: 7,
                                  blurRadius: 7,
                                  color: Color.fromRGBO(31, 36, 39, 0.6)
                              )
                            ]
                        ),
                        child: Center(
                          child: Text(loading2 ? 'Загрузка..' : 'Выход', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
                        ),
                      ),
                    )
                  ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget SettingContainer(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff4E47A8)),
        borderRadius: BorderRadius.circular(14)
      ),
      padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
      margin: EdgeInsets.only(bottom: 11),
      child: Text(text, style: TextStyle(fontSize: 18.sp, fontFamily: 'Lato', fontWeight: FontWeight.w400, color: Color(0xff97969b)),),
    );
  }
}