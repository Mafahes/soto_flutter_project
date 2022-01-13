import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
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
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Настройки'),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoFormSection.insetGrouped(
                header: const Text('Личные данные'),
                children: [
                  CupertinoFormRow(
                    child: CupertinoTextFormFieldRow(
                      onChanged: (v) => setState(() {

                      }),
                      placeholder: 'Введите ФИО',
                    ),
                    prefix: Text('ФИО'),
                  ),
                  CupertinoFormRow(
                    child: CupertinoTextFormFieldRow(
                      onChanged: (v) => setState(() {

                      }),
                      placeholder: 'Введите E-Mail',
                    ),
                    prefix: Text('E-Mail'),
                  ),
                ]
            ),
            CupertinoFormSection.insetGrouped(
                header: const Text('Настройки приложения'),
                children: [
                  CupertinoFormRow(
                    child: CupertinoSwitch(
                        value: true, onChanged: (v) {

                    }
                    ),
                    prefix: Text('Геопозиция'),
                  ),
                  CupertinoFormRow(
                    child: CupertinoSwitch(
                        value: true, onChanged: (v) {

                    }
                    ),
                    prefix: Text('Уведомления'),
                  )
                ]
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CupertinoButton(
                        color: CupertinoColors.activeBlue,
                        child: Text('Проверить геопозицию'),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                        }
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CupertinoButton(
                        color: CupertinoColors.destructiveRed,
                        child: Text('Выйти из аккаунта'),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                        }
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}