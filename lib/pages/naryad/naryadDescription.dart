// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soto_project/shared/interface/OrderById.dart';

class NaryadDescription extends StatefulWidget {
  final OrderById order;
  NaryadDescription({Key? key, required this.order}) : super(key: key);

  @override
  _NaryadDescriptionState createState() {
    return _NaryadDescriptionState();
  }
}

class _NaryadDescriptionState extends State<NaryadDescription> {
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
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back_ios_outlined, color: Colors.white,),
                                SizedBox(width: 10,),
                                Text('Назад', style: TextStyle(fontFamily: 'Lato', fontSize: 14, color: Colors.white),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 28),
                        Text('Дополнительные сведения', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 12),),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 250,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff4E47A8), width: 1.0),
                            borderRadius: BorderRadius.circular(14)
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.order.addInformation ?? '', style: TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );;
  }
}