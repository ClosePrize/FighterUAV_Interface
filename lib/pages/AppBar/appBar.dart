import 'package:flutter/material.dart';
import 'package:savasan_interface_2024/colors.dart';
import 'package:savasan_interface_2024/pages/AppBar/widgets.dart';
import 'dart:io';

Container asdsdaasd (context){

  void main() async {
    var file = File('path/to/save/video.mp4');

    var socket = await Socket.connect('server_ip', 12345);
    print('Connected to server: ${socket.remoteAddress}:${socket.remotePort}');

    socket.listen((data) {
      file.writeAsBytes(data, mode: FileMode.append);
    }, onDone: () {
      socket.close();
      print('Video received successfully');
    });
  }

  return Container(

  );
}

AppBar interfaceAppBar (context, String mode, bool isConnectedApi,double telemetriSagligi){
  return AppBar(
    backgroundColor: thirdPalette4,
    flexibleSpace: Container(
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/15, 0, MediaQuery.of(context).size.width/15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Mod: ",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              modWidget(context, Colors.orange,/*"Guided"*/mode),
              SizedBox(width: MediaQuery.of(context).size.width/15,),
              Text(
                "Telemetri Sağlığı: ",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              telemetriHealthWidget(context, Colors.yellow, telemetriSagligi),
              SizedBox(width: MediaQuery.of(context).size.width/15,),
              appBarInformationWidget(context, "Api Bağlantısı ",true, Colors.grey, isConnectedApi),
              SizedBox(width: MediaQuery.of(context).size.width/15,),
              appBarInformationWidget(context, "Ssh Bağlantısı ",true, Colors.grey, true),
              SizedBox(width: MediaQuery.of(context).size.width/15,),
              appBarInformationWidget(context, "IP adresi 42.38.11.34 ",false, Colors.grey, false),
            ],
          ),
        ],
      ),
    ),
  );
}