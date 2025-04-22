import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savasan_interface_2024/colors.dart';
import 'package:savasan_interface_2024/remoteService.dart';
import 'package:savasan_interface_2024/pages/TelemetriWidget/telemetry.dart';
import 'package:savasan_interface_2024/pages/TelemetriWidget/widgets.dart';

class TelemetriInf extends StatefulWidget{
  final Telemetry telemetryInfo;

  const TelemetriInf({super.key, required this.telemetryInfo});

  @override
  State<TelemetriInf> createState() => _TelemetriInfState();
}

class _TelemetriInfState extends State<TelemetriInf>{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width/4,
      height: MediaQuery.of(context).size.height/1.8,
      decoration: BoxDecoration(
        color: thirdPalette3,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget(context, 3,"Koordinatlar", "Latitude", "Longtitude", "Altitude","","",/*40.98923,28.72541,29.98745*/widget.telemetryInfo.lat,widget.telemetryInfo.lon,widget.telemetryInfo.alt),
          SizedBox(height: 20,),
          textWidget(context, 3,"Açılar ", "Roll", "Pitch", "Yaw","","",/*0.00238,8.67511,-5.47615*/widget.telemetryInfo.roll,widget.telemetryInfo.pitch,widget.telemetryInfo.yaw),
          /*Text(
            "Açılar ",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          ),*/
          /*Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width/8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Roll: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Pitch: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Yaw: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),*/
          SizedBox(height: 20,),
          vfrWidget(context, 5, "VFR_HUD", "Airspeed", "Groundspeed", "Heading", "Throttle", "Climb",/*11.54974,12.34166,252.75697*/widget.telemetryInfo.airspeed,widget.telemetryInfo.groundspeed,widget.telemetryInfo.heading,widget.telemetryInfo.throttle,widget.telemetryInfo.climb),
          // Text(
          //   "VFR_HUD ",
          //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          // ),
          // Container(
          //   padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width/8,
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.black),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "Airspeed: ",
          //           style: TextStyle(
          //               fontSize: 20
          //           ),
          //         ),
          //         Text(
          //           "Groundspeed: ",
          //           style: TextStyle(
          //               fontSize: 20
          //           ),
          //         ),
          //         Text(
          //           "Heading: ",
          //           style: TextStyle(
          //               fontSize: 20
          //           ),
          //         ),
          //         Text(
          //           "Throttle: ",
          //           style: TextStyle(
          //               fontSize: 20
          //           ),
          //         ),
          //         Text(
          //           "Climb: ",
          //           style: TextStyle(
          //               fontSize: 20
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}