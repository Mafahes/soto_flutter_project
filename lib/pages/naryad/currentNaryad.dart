// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soto_project/pages/naryad/fileList.dart';
import 'package:soto_project/pages/naryad/naryadDescription.dart';
import 'package:soto_project/pages/naryad/naryadMap.dart';
import 'package:soto_project/shared/api.dart';
import 'package:soto_project/shared/interface/Order.dart';
import 'package:soto_project/shared/interface/OrderById.dart';

class CurrentNaryadPage extends StatefulWidget {
  final Order order;
  CurrentNaryadPage({Key? key, required this.order}) : super(key: key);

  @override
  _CurrentNaryadPageState createState() {
    return _CurrentNaryadPageState();
  }
}

class _CurrentNaryadPageState extends State<CurrentNaryadPage> {
  BoxDecoration blueButton = BoxDecoration(
      color: Color(0xff2c2e33),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 1.0, color: Color(0xff7A7FF3)),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff7A7FF3),
            Color(0xff254BAF)
          ]
      ),
      boxShadow: [
        BoxShadow(
            offset: Offset(4, 4),
            spreadRadius: 7,
            blurRadius: 7,
            color: Color.fromRGBO(31, 36, 39, 0.6)
        )
      ]
  );
  TextEditingController fio = TextEditingController();
  TextEditingController lvl = TextEditingController();
  TextEditingController desc = TextEditingController();
  List<int> files = [];
  bool loading = false;
  OrderById? order;
  @override
  void initState() {
    ApiClient().getOrderById(widget.order.id).then((value) {
      setState(() {
        order = value!;
        order?.history = [];
        order?.user = null;
        order?.brigade = null;
      });
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
      backgroundColor: Color(0xff2c2e33),
      body: Stack(
        children: [
          SafeArea(
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
                        child: Text(
                          'Наряд №${order?.id ?? '-'}', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          order == null ? Container() : GestureDetector(
                            child: Icon(
                              Icons.file_download, color: Colors.white,),
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (c) => FileListPage(order: order!))
                              ).then((value) {
                                if(value != null && value == []) return;
                                setState(() {
                                  order = null;
                                });
                                ApiClient().getOrderById(widget.order.id).then((value) {
                                  setState(() {
                                    order = value!;
                                    order?.history = [];
                                    order?.user = null;
                                    order?.brigade = null;
                                  });
                                });
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: order == null ? Center(
                    child: CircularProgressIndicator(),
                  ) : Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Адрес заявки', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 12.sp),),
                        SizedBox(height: 10),
                        containedText(order!.address, true, true, '', () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(builder: (c) => NaryadMapPage(order: widget.order))
                          );
                          HapticFeedback.lightImpact();
                        }),
                        SizedBox(height: 11),
                        ...Conditional.list(
                            context: context,
                            conditionBuilder: (c) => true == true,
                            widgetBuilder: (c) => [
                              containedText("ФИО умершего", false, false, '${order!.secondName ?? ''} ${order!.firstName?.substring(0, 1)}.${order!.patronymic?.substring(0, 1)}.', () {
                                HapticFeedback.lightImpact();
                              }),
                              SizedBox(height: 11),
                              containedText("Возраст умершего", false, false, '${order!.age}', () {
                                HapticFeedback.lightImpact();
                              }),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              Text('Адрес морга', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 12.sp),),
                              SizedBox(height: 10),
                              containedText((order?.addressMorgue ?? '') == '' ? 'Адрес отсутствует' : order?.addressMorgue ?? 'Адрес отсутствует', true, true, '', () {
                                HapticFeedback.lightImpact();
                              }),
                              SizedBox(height: 10),
                              containedText('Доп.сведения', false, true, '', () {
                                HapticFeedback.lightImpact();
                                Navigator.of(context).push(
                                  CupertinoPageRoute(builder: (c) => NaryadDescription(order: order!))
                                );
                              }),
                              Spacer(),
                            ],
                            fallbackBuilder: (c) => [
                              styledTextField('ФИО сотрудника морга', fio),
                              SizedBox(height: 13),
                              styledTextField('Должность', lvl),
                              SizedBox(height: 13),
                              styledTextField('Доп.сведения', desc),
                              SizedBox(height: 35),
                              Text('Сопроводительный лист', style: TextStyle(fontFamily: 'Lato', fontSize: 12.sp, color: Colors.white),),
                              SizedBox(height: 6),
                              GestureDetector(
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    File file = File(result.files.single.path!);
                                    setState(() {
                                      loading = true;
                                    });
                                    ApiClient().uploadFile(file).then((value) {
                                      setState(() {
                                        files.add(value[0]['id']);
                                        loading = false;
                                      });
                                    });
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(width: 1.0, color: Color(0xff6459E9))
                                  ),
                                  child: Center(
                                    child: Text('Выберите файл', style: TextStyle(fontSize: 18.sp, fontFamily: 'Lato', color: Color(0xff6459E9)),),
                                  ),
                                ),
                              ),
                              SizedBox(height: 17,),
                              Center(
                                child: Text(
                                  'Количество прикрепленных файлов: ${files.length}', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Lato', fontSize: 14, color: Color(0xffa2a3a7)),),
                              ),
                              Spacer()
                            ]
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (c) => order!.state == 1,
                            widgetBuilder: (c) => GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                ApiClient().editOrder({
                                  ...order!.toJson(),
                                  "state": 2
                                }).then((value) {
                                  Navigator.of(context).pop(true);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
                                margin: EdgeInsets.only(bottom: 11),
                                decoration: blueButton,
                                child: Center(
                                  child: Text('Принять', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontFamily: 'Lato'),),
                                ),
                              ),
                            ),
                            fallbackBuilder: (c) => Container()
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (c) => order!.state == 2,
                            widgetBuilder: (c) => GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                setState(() {
                                  loading = true;
                                });
                                ApiClient().editOrder({
                                  ...order!.toJson(),
                                  "state": 3
                                }).then((value) {
                                  Navigator.of(context).pop(true);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
                                margin: EdgeInsets.only(bottom: 11),
                                decoration: blueButton,
                                child: Center(
                                  child: Text('Прибыл на место', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontFamily: 'Lato'),),
                                ),
                              ),
                            ),
                            fallbackBuilder: (c) => Container()
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (c) => order!.state == 3,
                            widgetBuilder: (c) => GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                setState(() {
                                  loading = true;
                                });
                                ApiClient().editOrder({
                                  ...order!.toJson(),
                                  "state": 4
                                }).then((value) {
                                  Navigator.of(context).pop(true);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
                                margin: EdgeInsets.only(bottom: 11),
                                decoration: blueButton,
                                child: Center(
                                  child: Text('Выехал в морг', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontFamily: 'Lato'),),
                                ),
                              ),
                            ),
                            fallbackBuilder: (c) => Container()
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (c) => order!.state == 4,
                            widgetBuilder: (c) => GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                setState(() {
                                  loading = true;
                                });
                                ApiClient().editOrder({
                                  ...order!.toJson(),
                                  "state": 5
                                }).then((value) {
                                  Navigator.of(context).pop(true);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
                                margin: EdgeInsets.only(bottom: 11),
                                decoration: blueButton,
                                child: Center(
                                  child: Text('Сдал тело', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontFamily: 'Lato'),),
                                ),
                              ),
                            ),
                            fallbackBuilder: (c) => Container()
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (c) => order!.state == 2 || order!.state == 1,
                            widgetBuilder: (c) => GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                setState(() {
                                  loading = true;
                                });
                                ApiClient().editOrder({
                                  ...order!.toJson(),
                                  "state": 6
                                }).then((value) {
                                  Navigator.of(context).pop(true);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 23, vertical: 17),
                                margin: EdgeInsets.only(bottom: 11),
                                decoration: BoxDecoration(
                                    color: Color(0xffFF6666),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 1.0, color: Color(0xffF7ABA6)),
                                    // gradient: LinearGradient(
                                    //     begin: Alignment.topLeft,
                                    //     end: Alignment.bottomRight,
                                    //     colors: [
                                    //       Color(0xffFF6666)
                                    //     ]
                                    // ),
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
                                  child: Text('Отклонить', style: TextStyle(color: Colors.white, fontSize: 18.sp, fontFamily: 'Lato'),),
                                ),
                              ),
                            ),
                            fallbackBuilder: (c) => Container()
                        ),
                        SizedBox(height: 22,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          !loading ? Container() : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
  Widget containedText(String text, bool filled, bool arrow, String subtext, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        decoration: BoxDecoration(
          color: filled ? Color(0xff4E47A8) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Color(0xff4E47A8), width: filled ? 0 : 1)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 18.sp),),
            ),
            arrow ? Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,) : Container(),
            subtext.isEmpty ? Container() : Text(subtext, style: TextStyle(fontFamily: 'Lato', color: Color(0xffC6C6C8), fontSize: 18.sp),)
          ],
        ),
      ),
    );
  }
  Widget styledTextField(text, controller) {
    return Container(
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff111112).withOpacity(0.1), Color(0xff111112).withOpacity(0.1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.4],
          tileMode: TileMode.clamp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        onChanged: (v) {
          setState(() {

          });
        },
        controller: controller,
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
            hintText: text,
            fillColor: Color.fromRGBO(34, 37, 42, 0.2)
        ),
      ),
    );
  }
}