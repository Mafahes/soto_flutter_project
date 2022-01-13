import 'package:flutter/material.dart';
import 'package:soto_project/pages/initPage.dart';
import 'package:soto_project/pages/login.dart';

void main() {
  runApp(MainWidget());
}
class MainWidget extends StatefulWidget {
  MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() {
    return _MainWidgetState();
  }
}

class _MainWidgetState extends State<MainWidget> {
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
    return MaterialApp(
      home: LoginPage(),
    );
  }
}