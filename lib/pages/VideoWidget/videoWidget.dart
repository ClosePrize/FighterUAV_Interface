import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savasan_interface_2024/colors.dart';
import 'package:udp/udp.dart';
import 'package:dart_vlc/dart_vlc.dart';

import '../AppBar/widgets.dart';

class VideoWidget extends StatefulWidget{
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => VideoWidgetState();
}
// String rtsp1 = 'http://11.42.38.234:8000/video_feed';
String rtsp1 = 'http://10.0.0.70:8000/video_feed';
// String rtsp1 = 'udp/ts://@10.0.0.71:8000';
String udp1 = 'udp://11.42.38.121:480';

class VideoWidgetState extends State<VideoWidget>{

  void refreshVideo() {
    print("refresh");
    player.stop();
    player.open(
      Playlist(medias: medias),
    );
  }

  @override
  Player player = Player(
    id: 0,
    videoDimensions: const VideoDimensions(640, 360),
  );
  MediaType mediaType = MediaType.file;
  CurrentState current = CurrentState();
  PositionState position = PositionState();
  PlaybackState playback = PlaybackState();
  GeneralState general = GeneralState();
  VideoDimensions videoDimensions = const VideoDimensions(0, 0);
  List<Media> medias = <Media>[
    Media.network(rtsp1),
  ];
  List<Device> devices = <Device>[];
  // TextEditingController controller = TextEditingController();
  // TextEditingController metasController = TextEditingController();
  double bufferingProgress = 0.0;
  Media? metadataCurrentMedia;

  @override
  void initState() {
    super.initState();
    DartVLC.initialize();
    player.currentStream.listen((value) {
      setState(() => current = value);
    });
    player.positionStream.listen((value) {
      setState(() => position = value);
    });
    player.playbackStream.listen((value) {
      setState(() => playback = value);
    });
    player.generalStream.listen((value) {
      setState(() => general = value);
    });
    player.videoDimensionsStream.listen((value) {
      setState(() => videoDimensions = value);
    });
    player.bufferingProgressStream.listen(
          (value) {
        setState(() => bufferingProgress = value);
      },
    );
    player.errorStream.listen((event) {
      debugPrint('libVLC error.');
    });
    devices = Devices.all;
    Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
    equalizer.setPreAmp(10.0);
    equalizer.setBandAmp(31.25, 10.0);
    player.setEqualizer(equalizer);

    player.open(
      Playlist(medias: medias),
    );
  }

  startVideo()async{
    player.currentStream.listen((value) {
      setState(() => current = value);
    });
    player.positionStream.listen((value) {
      setState(() => position = value);
    });
    player.playbackStream.listen((value) {
      setState(() => playback = value);
    });
    player.generalStream.listen((value) {
      setState(() => general = value);
    });
    player.videoDimensionsStream.listen((value) {
      setState(() => videoDimensions = value);
    });
    player.bufferingProgressStream.listen(
          (value) {
        setState(() => bufferingProgress = value);
      },
    );
    player.errorStream.listen((event) {
      debugPrint('libVLC error.');
    });
    devices = Devices.all;
    Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
    equalizer.setPreAmp(10.0);
    equalizer.setBandAmp(31.25, 10.0);
    player.setEqualizer(equalizer);

    player.open(
      Playlist(medias: medias),
    );
  }

  getData()async{
    var receiver = await UDP.bind(Endpoint.loopback(port: Port(65001)));
  }
  udpDinle()async{
    // RawDatagramSocket.bind("42.11.38.4", 9999);
    RawDatagramSocket.bind(InternetAddress("11.42.38.4"), 9999).then((socket){
      socket.listen((RawSocketEvent event) {
        if(event == RawSocketEvent.read){
          print(socket.receive());
          Datagram? dg = socket.receive();
          if(dg == null) return;
          final gelenVeri = String.fromCharCodes(dg.data);
          print(gelenVeri);
        }
      });
      // socket.listen((RawDatagramSocket event){
      //   if(event == RawSocketEvent.read){
      //     Datagram? dg = socket.receive();
      //     if(dg == null){return}
      //     final gelenVeri = String.fromCharCodes(dg.data);
      //     print(gelenVeri);
      //   }
      // });
    });
  }

  @override
  Widget build(BuildContext context){
    bool isTablet;
    bool isPhone;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 640,
          height: 480,
          decoration: BoxDecoration(
            color: Colors.transparent,
            // borderRadius: BorderRadius.only(
            //   topRight: Radius.circular(20.0),
            // ),
          ),
          // child: Column(
          //   children: [
          //     ElevatedButton(onPressed: (){
          //       udpDinle();
          //     },
          //     child: Text("Başlat"),
          //     ),
          //   ],
          // ),
          // child: Image.asset('assets/savasan3.jpg'),
          child: Video(
            player: player,
            width: MediaQuery.of(context).size.width * 0.33,
            height: MediaQuery.of(context).size.height * 0.33,
            volumeThumbColor: Colors.blue,
            volumeActiveColor: Colors.blue,
            showControls: !isPhone,
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: (){
            refreshVideo();
            print("object");
          },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: thirdPalette5
            ),
          child: appBarInformationWidget(context, "Yenile", false, thirdPalette1, false)
        )
      ],
    );
  }
}