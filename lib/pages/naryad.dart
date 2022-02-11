import 'package:flutter/material.dart';
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
              child: Center(
                child: Text(
                  'Заявки', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 28, fontWeight: FontWeight.bold),),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text('У вас нет активных заявок.', style: TextStyle(color: Color(0xff7F8489), fontSize: 16, fontFamily: 'Lato'),),
              ),
            )
          ],
        ),
      ),
    );
  }
}