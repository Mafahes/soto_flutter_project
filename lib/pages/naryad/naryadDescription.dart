// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soto_project/shared/api.dart';
import 'package:soto_project/shared/interface/OrderById.dart';

class NaryadDescription extends StatefulWidget {
  final OrderById order;
  final bool isComment;
  NaryadDescription({Key? key, required this.order, required this.isComment}) : super(key: key);

  @override
  _NaryadDescriptionState createState() {
    return _NaryadDescriptionState();
  }
}

class _NaryadDescriptionState extends State<NaryadDescription> {
  TextEditingController comment = TextEditingController();
  bool loading = false;
  @override
  void initState() {
    setState(() {
      comment.text = widget.order.comment;
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
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                            Text('Комментарий', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 12),),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 250,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff4E47A8), width: 1.0),
                                borderRadius: BorderRadius.circular(14)
                              ),
                              child: widget.isComment ? TextField(
                                controller: comment,
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
                                      filled: false,
                                      hintStyle: TextStyle(color: Color(0xff7F8489)),
                                      hintText: "Текст...",

                                  ),
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                  maxLines: 10,
                                  minLines: 6) : SingleChildScrollView(
                                child: Text(
                                  widget.order.addInformation ?? '', style: TextStyle(color: Colors.white, fontSize: 18),),
                              ),
                            ),
                            SizedBox(height: 10),
                            !widget.isComment ? Container() : GestureDetector(
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                setState(() {
                                  loading = true;
                                });
                                await ApiClient().editOrder({
                                  ...widget.order.toJson(),
                                  "comment": comment.text
                                });
                                setState(() {
                                  loading = false;
                                });
                                Navigator.of(context).pop();
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
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                  child: Text('Отправить', style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato'),),
                                ),
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
      ),
    );;
  }
}