// ignore_for_file: prefer_is_empty, prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soto_project/pages/naryad/currentNaryad.dart';
import 'package:soto_project/shared/api.dart';
import 'package:soto_project/shared/interface/Order.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  List<Order>? orders = [];
  bool loading = true;
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      ApiClient().getActiveOrders().then((value) {
        setState(() {
          orders = value;
          loading = false;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if(timer.isActive) {
      timer.cancel();
    }
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
                      'Заявки', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: loading ? Center(
                child: CircularProgressIndicator(),
              ) : orders?.length == 0 ? Center(
                child: Text('У вас нет активных заявок.', style: TextStyle(color: Color(0xff7F8489), fontSize: 16, fontFamily: 'Lato'),),
              ) : ListView(
                children: orders?.map((e) => GestureDetector(
                  onTap: () async {
                    if(e.state == 5) return;
                    HapticFeedback.lightImpact();
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (c) => CurrentNaryadPage(order: e))
                    ).then((v) {
                      if(v == true) {
                        setState(() {
                          loading = true;
                        });
                        ApiClient().getActiveOrders().then((value) {
                          if(!mounted) return;
                          setState(() {
                            orders = value;
                            loading = false;
                          });
                        });
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xff46a573),
                        borderRadius: BorderRadius.circular(14)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 17),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Наряд #${e.code}', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 18),),
                        Spacer(),
                        Text(Prefs.orderStatuses[e.state], style: TextStyle(color: Color(0xff2A2C30), fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 18),),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                )).toList() ?? [],
              ),
            )
          ],
        ),
      ),
    );
  }
}