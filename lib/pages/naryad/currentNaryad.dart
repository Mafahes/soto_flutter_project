// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soto_project/pages/naryad/naryadMap.dart';
import 'package:soto_project/shared/api.dart';
import 'package:soto_project/shared/interface/Order.dart';

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
    return Scaffold(
      backgroundColor: Color(0xff2c2e33),
      body: SafeArea(
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
                      'Наряд №${widget.order.id}', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Адрес заявки', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 12),),
                    SizedBox(height: 10),
                    containedText(widget.order.address, true, true, '', () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(builder: (c) => NaryadMapPage(order: widget.order))
                      );
                      HapticFeedback.lightImpact();
                    }),
                    SizedBox(height: 11),
                    ...Conditional.list(
                        context: context,
                        conditionBuilder: (c) => widget.order.state != 4,
                        widgetBuilder: (c) => [
                          containedText("ФИО умершего", false, false, '${widget.order.secondName ?? ''} ${widget.order.firstName?.substring(0, 1)}.${widget.order.patronymic?.substring(0, 1)}.', () {
                            HapticFeedback.lightImpact();
                          }),
                          SizedBox(height: 11),
                          containedText("Возраст умершего", false, false, '${widget.order.age}', () {
                            HapticFeedback.lightImpact();
                          }),
                          SizedBox(height: 72),
                          Text('Адрес морга', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 12),),
                          SizedBox(height: 10),
                          containedText(widget.order.source ?? '', true, true, '', () {
                            HapticFeedback.lightImpact();
                          }),
                          SizedBox(height: 10),
                          containedText('Доп.сведения', false, true, '', () {
                            HapticFeedback.lightImpact();
                          }),
                          Spacer(),
                        ],
                        fallbackBuilder: (c) => [
                          Text('hello')
                        ]
                    ),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (c) => widget.order.state == 1,
                        widgetBuilder: (c) => GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            ApiClient().editOrder({
                              ...widget.order.toJson(),
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
                              child: Text('Принять', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
                            ),
                          ),
                        ),
                        fallbackBuilder: (c) => Container()
                    ),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (c) => widget.order.state == 2,
                        widgetBuilder: (c) => GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            ApiClient().editOrder({
                              ...widget.order.toJson(),
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
                              child: Text('Прибыл на место', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
                            ),
                          ),
                        ),
                        fallbackBuilder: (c) => Container()
                    ),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (c) => widget.order.state == 3,
                        widgetBuilder: (c) => GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            ApiClient().editOrder({
                              ...widget.order.toJson(),
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
                              child: Text('Выехал в морг', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
                            ),
                          ),
                        ),
                        fallbackBuilder: (c) => Container()
                    ),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (c) => widget.order.state == 4,
                        widgetBuilder: (c) => GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            ApiClient().editOrder({
                              ...widget.order.toJson(),
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
                              child: Text('Сдал тело', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
                            ),
                          ),
                        ),
                        fallbackBuilder: (c) => Container()
                    ),
                    Conditional.single(
                        context: context,
                        conditionBuilder: (c) => widget.order.state == 2 || widget.order.state == 1,
                        widgetBuilder: (c) => GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            ApiClient().editOrder({
                              ...widget.order.toJson(),
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
                              child: Text('Отклонить', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
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
                text, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 18),),
            ),
            arrow ? Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,) : Container(),
            subtext.isEmpty ? Container() : Text(subtext, style: TextStyle(fontFamily: 'Lato', color: Color(0xffC6C6C8), fontSize: 18),)
          ],
        ),
      ),
    );
  }
}