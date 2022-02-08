import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soto_project/pages/naryad.dart';
import 'package:soto_project/pages/settings.dart';

class InitPage extends StatefulWidget {
  InitPage({Key? key}) : super(key: key);

  @override
  _InitPageState createState() {
    return _InitPageState();
  }
}

class _InitPageState extends State<InitPage> {
  var index = 0;
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
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Color(0xff2f3034),
        onTap: (i) {
          setState(() {
            index = i;
          });
          HapticFeedback.lightImpact();
        },
        items: [
          BottomNavigationBarItem(
              label: 'Наряд',
              icon: SvgPicture.asset('assets/menu/icon1.svg', width: 20, height: 20, color: index == 0 ? null : Colors.white,)
          ),
          BottomNavigationBarItem(
              label: "Заявки",
              icon: SvgPicture.asset('assets/menu/icon2.svg', width: 20, height: 20, color: index == 1 ? null : Colors.white,)
          ),
          BottomNavigationBarItem(
              label: "Настройки",
              icon: SvgPicture.asset('assets/menu/icon3.svg', width: 20, height: 20, color: index == 2 ? null : Colors.white,)
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return NaryadPage();
          default:
            return NaryadPage();
        }
      },
    );
  }
}