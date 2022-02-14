import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soto_project/pages/settings.dart';
import 'package:soto_project/shared/api.dart';

class NaryadPage extends StatefulWidget {
  NaryadPage({Key? key}) : super(key: key);

  @override
  _NaryadPageState createState() {
    return _NaryadPageState();
  }
}

class _NaryadPageState extends State<NaryadPage> {
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
                      'Заявки', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: true ? TextButton(
                    onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) => SettingsPage(onExit: () {})));
                }, child: Text('hldf')) : Text('У вас нет активных заявок.', style: TextStyle(color: Color(0xff7F8489), fontSize: 16, fontFamily: 'Lato'),),
              ),
            )
          ],
        ),
      ),
    );
  }
}