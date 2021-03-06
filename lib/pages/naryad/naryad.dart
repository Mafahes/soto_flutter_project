import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soto_project/pages/naryad/currentNaryad.dart';
import 'package:soto_project/pages/settings.dart';
import 'package:soto_project/shared/api.dart';
import 'package:soto_project/shared/interface/Order.dart';

class NaryadPage extends StatefulWidget {
  NaryadPage({Key? key}) : super(key: key);

  @override
  _NaryadPageState createState() {
    return _NaryadPageState();
  }
}

class _NaryadPageState extends State<NaryadPage> {
  List<Order>? orders = [];
  bool loading = true;
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      ApiClient().getNewOrders().then((value) {
        if(!mounted) return;
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
                      'Наряды', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: loading ? Center(
                child: CircularProgressIndicator(),
              ) : orders?.length == 0 ? Center(
                child: Text('У вас нет активных нарядов.', style: TextStyle(color: Color(0xff7F8489), fontSize: 16, fontFamily: 'Lato'),),
              ) : ListView(
                children: orders?.map((e) => GestureDetector(
                  onTap: () {
                    if(e.state == 5) return;
                    Navigator.of(context).push(
                      CupertinoPageRoute(builder: (c) => CurrentNaryadPage(order: e))
                    ).then((v) {
                      if(v == true) {
                        setState(() {
                          loading = true;
                        });
                        ApiClient().getNewOrders().then((value) {
                          setState(() {
                            orders = value;
                            loading = false;
                          });
                        });
                      }
                    });
                    HapticFeedback.lightImpact();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xff4F54C8),
                        borderRadius: BorderRadius.circular(14)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 17),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Наряд #${e.code}', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 18),),
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