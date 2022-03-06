// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:soto_project/shared/interface/OrderById.dart';

class NaryadMapPage extends StatefulWidget {
  final OrderById order;
  final bool isMorgue;
  NaryadMapPage({Key? key, required this.order, required this.isMorgue}) : super(key: key);

  @override
  _NaryadMapPageState createState() {
    return _NaryadMapPageState();
  }
}

class _NaryadMapPageState extends State<NaryadMapPage> {
  MapboxMapController? mapController;
  late Timer interval;
  @override
  void initState() {

    super.initState();
  }
  updateSymbols(event) async {
    if(!mounted) return;
    await mapController?.clearSymbols();
    await mapController?.addSymbol(
        SymbolOptions(
          geometry: LatLng(widget.order.latitude, widget.order.longitude),
          iconImage: "marker",
        )
    );
    await mapController?.addSymbol(
        SymbolOptions(
            geometry: LatLng(event.latitude, event.longitude),
            iconImage: "car",
            iconRotate: event.heading
        )
    );
  }
  @override
  void dispose() {
    if(interval.isActive) {
      interval.cancel();
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
                        Text('Адрес ${widget.isMorgue ? 'морга' : 'заявки'}', style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 12),),
                        SizedBox(height: 10),
                        containedText(widget.isMorgue ? widget.order.addressMorgue : widget.order.address, true, true, '', () {
                        }),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: MapboxMap(
                      annotationOrder: [
                        AnnotationType.symbol
                      ],
                      styleString: 'mapbox://styles/mafahes/ck7ytniby1cm81jlktlfxfuuh',
                      accessToken: 'sk.eyJ1IjoibWFmYWhlcyIsImEiOiJja3pud3B0bnkwNW1tMnBsaG1ieWJ5cG5pIn0.kipYW60b_4ZPN7RCL4meng',
                      initialCameraPosition: CameraPosition(target: LatLng(widget.order.latitude, widget.order.longitude), zoom: 12),
                      onMapCreated: (c) async {
                        setState(() {
                          mapController = c;
                        });
                        final ByteData bytes = await rootBundle.load("assets/marker.png");
                        final Uint8List list = bytes.buffer.asUint8List();
                        await c.addImage("marker", list);
                        await c.addSymbol(
                            SymbolOptions(
                              geometry: LatLng(widget.order.latitude, widget.order.longitude),
                              iconImage: "marker",
                            )
                        );
                        final ByteData bytes2 = await rootBundle.load("assets/car.png");
                        final Uint8List list2 = bytes2.buffer.asUint8List();
                        await c.addImage("car", list2);
                        var perm = await Geolocator.checkPermission();
                        if(perm != LocationPermission.denied) {
                          interval = Timer.periodic(Duration(seconds: 2), (timer) async {
                            var perm = await Geolocator.checkPermission();
                            if(perm != LocationPermission.denied) {
                              Geolocator.getCurrentPosition().then((value) {
                                updateSymbols(value);
                              });
                            }
                          });
                        }
                      },
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
  Widget containedText(String text, bool filled, bool arrow, String subtext, Function onTap) {
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
                text, maxLines: 4, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontFamily: 'Lato', fontSize: 18),),
            ),
            subtext.isEmpty ? Container() : Text(subtext, style: TextStyle(fontFamily: 'Lato', color: Color(0xffC6C6C8), fontSize: 18),)
          ],
        ),
      ),
    );
  }
}