import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:savasan_interface_2024/pages/MapWidget/MetroLines.dart';
import 'package:savasan_interface_2024/pages/MapWidget/planes.dart';

import '../CommandsWidget/commandModels.dart';
import '../TelemetriWidget/telemetry.dart';
import 'hss.dart';

class MapWidget extends StatefulWidget{
  List<KonumBilgileri> konums;
  List<PlanesTelemetry> enemyPlanesTelemetry;
  List<PlanesTelemetry> parsTelemetry;
  List<HssBilgileri> hssBilgileriList1;
  final Telemetry telemetryInfo;
  QrInf qrInf;

  MapWidget({super.key, required this.enemyPlanesTelemetry, required this.parsTelemetry, required this.konums, required this.telemetryInfo, required this.qrInf, required this.hssBilgileriList1});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget>{
  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: MetroLinesPage(enemyPlanesTelemetry: widget.enemyPlanesTelemetry,parsTelemetry: widget.parsTelemetry,konums: widget.konums, telemetryInfo: widget.telemetryInfo, qrInf: widget.qrInf, hssBilgileriList2: widget.hssBilgileriList1,)
      )
    );
  }
}