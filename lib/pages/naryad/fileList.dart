import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soto_project/shared/api.dart';
import 'package:soto_project/shared/interface/OrderById.dart';

class FileListPage extends StatefulWidget {
  OrderById order;
  FileListPage({Key? key, required this.order}) : super(key: key);

  @override
  _FileListPageState createState() {
    return _FileListPageState();
  }
}

class _FileListPageState extends State<FileListPage> {
  bool loading = true;
  OrderById? order;
  @override
  void initState() {
    ApiClient().getOrderById(widget.order.id).then((value) {
      setState(() {
        order = value;
        loading = false;
      });
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
                      'Прикрепленные файлы', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 20.sp, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: loading ? Center(
                child: CircularProgressIndicator(),
              ) : Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    ...?order?.files.map((e) => Column(
                      children: [
                        containedText('Файл ${e.fileId}', false, true, '', () {
                          print(e.file);
                          ApiClient().loadFileViewer(e.file.fullUrl).then((value) {
                            Share.shareFiles([value]);
                          });
                          HapticFeedback.lightImpact();

                        }, () async {
                          HapticFeedback.lightImpact();
                          var req = await showDialog(
                              context: context,
                              builder: (c) => AlertDialog(
                                title: Text('Удаление файла'),
                                content: Text('Вы действительно хотите удалить файл?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(c).pop(null);
                                      },
                                      child: Text('Нет')
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(c).pop(true);
                                      },
                                      child: Text('Да')
                                  )
                                ],
                              )
                          );
                          setState(() {
                            order?.files.removeWhere((element) => element.id == e.id);
                            order?.history = [];
                            order?.user = null;
                            order?.brigade = null;
                          });
                          if(req != true) return;
                          setState(() {
                            loading = true;
                          });
                          await ApiClient().editOrder(order?.toJson());
                          ApiClient().getOrderById(widget.order.id).then((value) {
                            setState(() {
                              order = value!;
                              loading = false;
                            });
                          });
                        }),
                        SizedBox(height: 20,)
                      ],
                    )).toList()
                  ],
                ),
              ),
            ),
            loading ? Container() : Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: containedText('Добавить файл', false, false, '', () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                if (result != null) {
                  File file = File(result.files.single.path!);
                  setState(() {
                    loading = true;
                  });
                  var src = await ApiClient().uploadFile(file);
                  setState(() {
                    order?.files.add(FileElement(fileId: src[0]['id']));
                    order?.history = [];
                    order?.user = null;
                    order?.brigade = null;
                  });
                  await ApiClient().editOrder({
                    ...?order?.toJson(),
                    "files": order?.files?.map((e) => {"fileId": e.fileId}).toList()
                  });
                  if(!mounted) return;
                  ApiClient().getOrderById(widget.order.id).then((value) {
                    if(!mounted) return;
                    setState(() {
                      order = value!;
                      loading = false;
                    });
                  });
                } else {
                  // User canceled the picker
                }
              }, () {

              }),
            )
          ],
        ),
      ),
    );
  }
  Widget containedText(String text, bool filled, bool arrow, String subtext, Function onTap, Function onDel) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        decoration: BoxDecoration(
            color: filled ? Color(0xff4E47A8) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Color(0xff4E47A8), width: filled ? 0 : 1)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 18.sp),),
            ),
            arrow ? GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                onDel();
              },
              child: Icon(
                Icons.remove_circle_outline, color: Colors.white,
              ),
            ) : Container(),
            subtext.isEmpty ? Container() : Text(subtext, style: TextStyle(fontFamily: 'Lato', color: Color(0xffC6C6C8), fontSize: 18.sp),)
          ],
        ),
      ),
    );
  }
}