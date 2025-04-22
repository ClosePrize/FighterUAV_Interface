import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savasan_interface_2024/colors.dart';
import 'package:savasan_interface_2024/dataConstants.dart';
import 'package:savasan_interface_2024/pages/AccountsWidget/accountsWidget.dart';
import 'package:savasan_interface_2024/pages/AppBar/appBar.dart';
import 'package:savasan_interface_2024/pages/AppBar/widgets.dart';
import 'package:savasan_interface_2024/pages/CommandsWidget/commandModels.dart';
import 'package:savasan_interface_2024/pages/CommandsWidget/commandsWidget.dart';
import 'package:savasan_interface_2024/pages/LogWidget/logWidget.dart';
import 'package:savasan_interface_2024/pages/MapWidget/MetroLines.dart';
import 'package:savasan_interface_2024/pages/MapWidget/hss.dart';
import 'package:savasan_interface_2024/pages/MapWidget/mapWidget.dart';
import 'package:savasan_interface_2024/pages/MapWidget/planes.dart';
import 'package:savasan_interface_2024/pages/TelemetriWidget/telemetriWidget.dart';
import 'package:savasan_interface_2024/pages/TelemetriWidget/telemetry.dart';
import 'package:savasan_interface_2024/pages/VideoWidget/videoWidget.dart';
import 'package:savasan_interface_2024/remoteService.dart';
import 'package:latlng/latlng.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  final GlobalKey<VideoWidgetState> videoKey = GlobalKey<VideoWidgetState>();

  void refresh() {
    videoKey.currentState?.refreshVideo();
    print("object1");
  }

  final enemyPlanesTelemetry = <PlanesTelemetry>[];
  final parsTelemetry = <PlanesTelemetry>[];
  int parsId = 0;
  List<KonumBilgileri> konums = [];
  var planeCount = 0;
  var isRefreshed = false;
  int target = 0;
  int modeNumber = 20;
  int manuelTarget = 0;
  String modeString = "Bilgi Yok";
  String targetString = "";
  String manuelTargetString = "";
  int saglik = 1;
  List<LogModel> logsa = [];

  List<HssBilgileri> hssBilgileriList = [];

  Telemetry telemetryInfo = Telemetry(lat: 40.98923, lon: 28.72541, alt: 29.98745, roll: 0.00238, pitch: 8.67511, yaw: -5.47615, airspeed: 11.54974, groundspeed: 12.34166, heading: 252.75697, throttle: 33.48795, climb: 8.67511, telemetriSagligi: 89, isConnectedApi: true, mode: "Land",
    logs: [
      Log(saat: 10,dakika: 57,saniye: 56,log: "Guided moda alındı."),
      Log(saat: 10,dakika: 58,saniye: 14,log: "Arm edildi."),
      Log(saat: 10,dakika: 58,saniye: 34,log: "Araç 30 metre kalkış komutu verildi."),
      Log(saat: 10,dakika: 59,saniye: 03,log: "Araç 30 metreye ulaştı."),
      Log(saat: 10,dakika: 59,saniye: 10,log: "Araç (40.98923,28.72541) konumuna doğru yola çıktı."),
      Log(saat: 11,dakika: 00,saniye: 41,log: "Araç hedefe ulaştı."),
      Log(saat: 11,dakika: 00,saniye: 46,log: "Araç Land moda alındı."),
      Log(saat: 11,dakika: 01,saniye: 57,log: "Araç iniş yaptı."),
      Log(saat: 11,dakika: 02,saniye: 02,log: "Araç disarm edildi."),
    ]
  );
  Telemetry telemetryInfo1 = Telemetry(lat: 40.98923, lon: 28.72541, alt: 29.98745, roll: 0.00238, pitch: 8.67511, yaw: -5.47615, airspeed: 11.54974, groundspeed: 12.34166, heading: 252.75697, throttle: 33.48795, climb: 8.67511, telemetriSagligi: 89, isConnectedApi: true, mode: "Land",
      logs: [
        Log(saat: 10,dakika: 57,saniye: 56,log: "Guided moda alındı."),
        Log(saat: 10,dakika: 58,saniye: 14,log: "Arm edildi."),
        Log(saat: 10,dakika: 58,saniye: 34,log: "Araç 50 metre kalkış komutu verildi."),
        Log(saat: 10,dakika: 59,saniye: 03,log: "Araç 50 metreye ulaştı."),
        Log(saat: 10,dakika: 59,saniye: 10,log: "Araç (40.98923,28.72541) konumuna doğru yola çıktı."),
        Log(saat: 10,dakika: 59,saniye: 10,log: "Araç (40.98852,28.72668) konumuna doğru yola çıktı."),
        Log(saat: 11,dakika: 00,saniye: 41,log: "Araç hedefe ulaştı."),
      ]
  );

  QrInf qr = QrInf(qrEnlem: 0, qrBoylam: 0);

  void getTelemetry() async {
    // while(true){
      // print("fonk çağrıldı");
      telemetryInfo = await RemoteService().getPlaneTelemetry();
      print(telemetryInfo.telemetriSagligi);
      if (telemetryInfo.telemetriSagligi > 100 ){
        saglik = 100;
      }
      else{
        saglik = telemetryInfo.telemetriSagligi.toInt();
      }
      logsa = [];
      for(int i = 0;i<telemetryInfo.logs.length;i++){
        LogModel log = LogModel(saat: telemetryInfo.logs[i].saat.toString(), dakika: telemetryInfo.logs[i].dakika.toString(), saniye: telemetryInfo.logs[i].saniye.toString(), log: telemetryInfo.logs[i].log);
        if(telemetryInfo.logs[i].saat<10){
          log.saat = "0${telemetryInfo.logs[i].saat.toString()}";
        }
        if(telemetryInfo.logs[i].dakika<10){
          log.dakika = "0${telemetryInfo.logs[i].dakika.toString()}";
        }
        if(telemetryInfo.logs[i].saniye<10){
          log.saniye = "1${telemetryInfo.logs[i].saniye.toString()}";
        }
        logsa.add(log);
      }
      // print("${telemetryInfo.lat} asdsad");
      // if(isRefreshed == true){
      //   break;
      // }
      // sleep(Duration(seconds:1));
      // Future.delayed(const Duration(seconds: 1), () {
      //   setState(() {
      //     getTelemetry();
      //   });
      // });
    // }
    // isRefreshed = false;
  }

  void getTargetAndModeNumber() async {
    target = (await RemoteService().getHedefInf()) as int;
    modeNumber = (await RemoteService().getModeInf()) as int;
    manuelTarget = (await RemoteService().getManuelHedefInf()) as int;

    if(manuelTarget == 999){
      manuelTargetString = "Yok";
    }
    else{
      manuelTargetString = manuelTarget.toString();
    }

    if(target == 888){
      targetString = "Yok";
    }
    else{
      targetString = target.toString();
    }

    switch(modeNumber) {
    case 0:
      modeString = "Takeoff";
      break;

    case 1:
      modeString = "Search and Follow";
      break;

    case 2:
      modeString = "Follow";
      break;

    case 3:
      modeString = "Kamikaze";
      break;

    case 4:
      modeString = "Land";
      break;

    default:
      modeString = "Idle-mode";
    }

  }

  void getHssData() async {
    if(isRed == 0){
      hssBilgileriList = await RemoteService().fetchHssBilgileri();
    }
    else{
      hssBilgileriList = [];
    }
      // Process or display the data as needed
      // hssBilgileriList.forEach((hss) {
      //   print('ID: ${hss.id}, Enlem: ${hss.hssEnlem}, Boylam: ${hss.hssBoylam}, Yarıçap: ${hss.hssYaricap}');
      // });

  }

  void getData() async {
    isRefreshed = false;
    double yonelme;
    Planes enemyPlanes = await RemoteService().getEnemyPlaneTelemetry();
    getHssData();
    if(enemyPlanes != null){
      /*setState(() {
        controller = MapController(
          location: LatLng(enemyPlanes.konumBilgileri[0].lat,enemyPlanes.konumBilgileri[0].lon),
          zoom: 11,
        );
      });*/
      konums = enemyPlanes.konumBilgileri;
      planeCount = enemyPlanes.konumBilgileri.length;
      print(planeCount);
      enemyPlanesTelemetry.clear();
      parsTelemetry.clear();
      for(int i = 0;i<planeCount;i++){
        if(enemyPlanes.konumBilgileri[i].yaw<0){
          yonelme = enemyPlanes.konumBilgileri[i].yaw + 360;
        }
        else{
          yonelme = enemyPlanes.konumBilgileri[i].yaw;
        }
        final enemyPlane = PlanesTelemetry(
            id: enemyPlanes.konumBilgileri[i].id,
            position: LatLng(enemyPlanes.konumBilgileri[i].lat, enemyPlanes.konumBilgileri[i].lon),
            yaw: yonelme,
            alt: enemyPlanes.konumBilgileri[i].alt,
        );
        if(parsId == enemyPlanes.konumBilgileri[i].id){
          parsTelemetry.add(enemyPlane);
        }
        else{
          enemyPlanesTelemetry.add(enemyPlane);
        }
      }
      // if(isRefreshed == false) {
      //   Future.delayed(const Duration(milliseconds: 500), () {
      //     setState(() {
      //       getData();
      //     });
      //   });
      //   setState(() {});
      // }
    }
  }

  void getQr() async {
    QrInf asd = await RemoteService().getQrInf();
    setState(() {
      qr = asd;
    });
  }
  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    startTimer();
    DartVLC.initialize();
    getQr();
    super.initState();
  }

  void startTimer() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        getData();
        getTelemetry();
        getTargetAndModeNumber();
        // print(modeString);
      });
      print('Timer tick: ${timer.tick}');
    });
  }

  int isRed = 0;

  // Function to toggle the color state
  void toggleColor() {
    setState(() {
      if(isRed == 0){
        setState(() {
          isRed = 1;
        });
      }
      else{
        setState(() {
          isRed = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: interfaceAppBar(context, telemetryInfo.mode, telemetryInfo.isConnectedApi, telemetryInfo.telemetriSagligi),
      appBar: AppBar(
        backgroundColor: thirdPalette4,
        flexibleSpace: Container(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/30, 0, MediaQuery.of(context).size.width/30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Durum: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  modWidget(context, Colors.red,/*"Guided"*/modeString),
                  SizedBox(width: MediaQuery.of(context).size.width/40,),
                  Text(
                    "Mod: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  modWidget(context, Colors.orange,/*"Guided"*/telemetryInfo.mode),
                  SizedBox(width: MediaQuery.of(context).size.width/40,),
                  Text(
                    "Telemetri Sağlığı: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  telemetriHealthWidget(context, Colors.yellow, saglik.toDouble()),
                  SizedBox(width: MediaQuery.of(context).size.width/40,),
                  appBarInformationWidget(context, "Api Bağlantısı ",true, Colors.grey, telemetryInfo.isConnectedApi),
                  SizedBox(width: MediaQuery.of(context).size.width/40,),
                  // appBarInformationWidget(context, "Ssh Bağlantısı ",true, Colors.grey, true),
                  // SizedBox(width: MediaQuery.of(context).size.width/40,),
                  appBarInformationWidget(context, "IP adresi $apiAddress ",false, Colors.grey, false),
                  SizedBox(width: MediaQuery.of(context).size.width/40,),
                  // ElevatedButton(
                  //   onPressed: (){
                  //     refresh();
                  //     print("object");
                  //   },
                  //     style: ElevatedButton.styleFrom(
                  //       padding: EdgeInsets.zero,
                  //       foregroundColor: Colors.brown
                  //     ),
                  //   child: appBarInformationWidget(context, "Yenile", false, Colors.grey, false)
                  // )
                  StreamBuilder<DateTime>(
                    stream: Stream<DateTime>.periodic(
                      Duration(seconds: 1),
                            (_) => DateTime.now(),
                    ),
                    builder: (context, snapshot) {
                      final timeString = _formatDateTime(DateTime.now());
                      return appBarInformationWidget(context, "$timeString ",false, Colors.grey, false);
                    },
                  ),
                  SizedBox(width: 40,),
                  Container(
                    height: MediaQuery.of(context).size.height/30,
                    // width: 20,
                    child: ElevatedButton(
                      // Button color changes based on `isRed` state
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isRed == 1 ? Colors.red : Colors.green, // Red if false, Green if true
                        // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      onPressed: toggleColor, // Call `toggleColor` on press
                      child: Text(
                        // isRed== 0 ? 'Turn Green' : 'Turn Red', // Update button text based on state
                        "HSS",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  thirdPalette1,
                  thirdPalette2,
                ],
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/1.8,
                  child:Row(
                    children: [
                      TelemetriInf(telemetryInfo: telemetryInfo),
                      SizedBox(width: 5),
                      Container(
                        width: 1,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(color: Colors.black,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      VideoWidget(),
                      MapWidget(enemyPlanesTelemetry: enemyPlanesTelemetry,parsTelemetry: parsTelemetry,konums: konums, telemetryInfo: telemetryInfo, qrInf: qr,hssBilgileriList1: hssBilgileriList,),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/4+6,
                  height: 5,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 1,
                        height: 5,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/4+6,
                      height: 5,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 1,
                            height: 5,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.2 - (MediaQuery.of(context).size.width/4 +16)+11,
                      height: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 1,
                            height: 5,
                            color: Colors.black,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        LogInf(logs: logsa),
                        SizedBox(width: 5),
                        Container(
                          width: 1,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(color: Colors.black,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Commands(),
                        SizedBox(width: 5),
                        Container(
                          width: 1,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(color: Colors.black,),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                        Accounts(targetString: targetString,manuelTargetString: manuelTargetString,),
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
          /*Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/4+5,
                color: Colors.transparent,
              ),
              Container(height: MediaQuery.of(context).size.height,color: Colors.black,width: 1,),
            ],
          ),*/
          /*Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/1.8+5,
                color: Colors.transparent,
              ),
              Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: 1,
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child:Container(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),*/
    );
  }
}
