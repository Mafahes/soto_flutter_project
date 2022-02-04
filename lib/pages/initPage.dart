import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soto_project/pages/settings.dart';

class InitPage extends StatefulWidget {
  InitPage({Key? key}) : super(key: key);

  @override
  _InitPageState createState() {
    return _InitPageState();
  }
}

class _InitPageState extends State<InitPage> {
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
        onTap: (i) {
          HapticFeedback.lightImpact();
        },
        items: const [
          BottomNavigationBarItem(
              label: "Наряд",
              icon: Icon(CupertinoIcons.bell_fill)
          ),
          BottomNavigationBarItem(
              label: "Заявки",
              icon: Icon(CupertinoIcons.doc)
          ),
          BottomNavigationBarItem(
              label: "Настройки",
              icon: Icon(CupertinoIcons.settings)
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 2:
            return SettingsPage();
          default:
            return Container();
        }
      },
    );
  }
}