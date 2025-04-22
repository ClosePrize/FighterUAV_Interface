import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savasan_interface_2024/colors.dart';
import 'package:savasan_interface_2024/pages/AccountsWidget/widgets.dart';

import '../../remoteService.dart';
import '../CommandsWidget/commandModels.dart';
import '../CommandsWidget/widgets.dart';

class Accounts extends StatefulWidget{
  final String targetString;
  final String manuelTargetString;
  const Accounts({super.key, required this.targetString, required this.manuelTargetString});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts>{
  final ipAddress = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Expanded(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
          decoration: BoxDecoration(
            color: thirdPalette3,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
            ),
          ),
          child:  Container(color: Colors.transparent,child: DefaultTabController(
          initialIndex: 1,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              flexibleSpace: const TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text("Takip"),
                  ),
                  Tab(
                    child: Text("Ayarlar"),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            body: TabBarView(
              children: <Widget>[
            Column(
                  children: [
                    Text(
                      "Takip edilen Hedef: ${widget.targetString}",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "Sabit takip: ${widget.manuelTargetString}",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 150,
                          child: TextField(
                            controller: ipAddress,
                            //cursorHeight: 15,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    armButton(context, thirdPalette4, "Takip et", 230, 60, () async {
                      setState(() async {
                        showAlertDialog(context, "Takip et","${ipAddress.text} numaralı aracı takip etmek istediğinize emin misiniz?","${ipAddress.text} numaralı araç takip ediliyor!",Colors.green, () async {
                          await RemoteService().sendTargetNumber(int.parse(ipAddress.text));
                          setState(() {
                            ipAddress.clear();
                          });
                        });
                      });
                    }),
                    SizedBox(height: 15,),
                    armButton(context, thirdPalette2, "Takibi bırak", 230, 60, () async {
                      setState(() async {
                        showAlertDialog(context, "Takibi bırak","${widget.targetString} numaralı aracın takibini bırakmak istediğinize emin misiniz?","${widget.targetString} numaralı aracın takibi bırakıldı!",Colors.green, () async {
                          await RemoteService().sendTargetNumber(999);
                        });
                      });
                    }),
                    // accounts(context,"Ssh Ip Adresi","Ssh Şifre"),
                    // SizedBox(height: 40,),
                    // accounts(context,"API Ip Adresi","API Key" ),

                  ],
                ),
                // Center(
                //   child: Text("It's rainy here"),
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child:Column(
                    children: [
                      Text("İstenilen Yükseklik ", style: TextStyle(fontSize: 15),textAlign: TextAlign.start,textDirection: TextDirection.rtl,),
                      SizedBox(height: 10,),
                      Container(
                        width: 300,
                        height: 40,
                        child: TextField(
                          controller: password,
                          //cursorHeight: 15,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ))
          // child: TabBar(
          //   tabs: [
          //     Column(
          //       children: [
          //         Text(
          //           "Takip edilen Hedef: ${widget.targetString}",
          //           style: TextStyle(fontSize: 20),
          //         ),
          //         SizedBox(height: 5,),
          //         Text(
          //           "Sabit takip: ${widget.manuelTargetString}",
          //           style: TextStyle(fontSize: 20),
          //         ),
          //         SizedBox(height: 15,),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Container(
          //               height: 40,
          //               width: 150,
          //               child: TextField(
          //                 controller: ipAddress,
          //                 //cursorHeight: 15,
          //                 decoration: InputDecoration(
          //                   filled: true,
          //                   fillColor: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 15,),
          //         armButton(context, thirdPalette4, "Takip et", 230, 60, () async {
          //           setState(() async {
          //             showAlertDialog(context, "Takip et","${ipAddress.text} numaralı aracı takip etmek istediğinize emin misiniz?","${ipAddress.text} numaralı araç takip ediliyor!",Colors.green, () async {
          //               await RemoteService().sendTargetNumber(int.parse(ipAddress.text));
          //               setState(() {
          //                 ipAddress.clear();
          //               });
          //             });
          //           });
          //         }),
          //         SizedBox(height: 15,),
          //         armButton(context, thirdPalette2, "Takibi bırak", 230, 60, () async {
          //           setState(() async {
          //             showAlertDialog(context, "Takibi bırak","${widget.targetString} numaralı aracın takibini bırakmak istediğinize emin misiniz?","${widget.targetString} numaralı aracın takibi bırakıldı!",Colors.green, () async {
          //               await RemoteService().sendTargetNumber(999);
          //             });
          //           });
          //         }),
          //         // accounts(context,"Ssh Ip Adresi","Ssh Şifre"),
          //         // SizedBox(height: 40,),
          //         // accounts(context,"API Ip Adresi","API Key" ),
          //
          //       ],
          //     ),
          //     Container(
          //       color: Colors.red,
          //       height: 150,
          //       width: 150,
          //     )
          //   ],
          // ),
          // child: Column(
          //   children: [
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(decoration: BoxDecoration(border: Border()),child: Text("Takip"),),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Text(
          //           "Takip edilen Hedef: ${widget.targetString}",
          //           style: TextStyle(fontSize: 20),
          //         ),
          //         SizedBox(height: 5,),
          //         Text(
          //           "Sabit takip: ${widget.manuelTargetString}",
          //           style: TextStyle(fontSize: 20),
          //         ),
          //         SizedBox(height: 15,),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Container(
          //               height: 40,
          //               width: 150,
          //               child: TextField(
          //                 controller: ipAddress,
          //                 //cursorHeight: 15,
          //                 decoration: InputDecoration(
          //                   filled: true,
          //                   fillColor: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 15,),
          //         armButton(context, thirdPalette4, "Takip et", 230, 60, () async {
          //           setState(() async {
          //             showAlertDialog(context, "Takip et","${ipAddress.text} numaralı aracı takip etmek istediğinize emin misiniz?","${ipAddress.text} numaralı araç takip ediliyor!",Colors.green, () async {
          //               await RemoteService().sendTargetNumber(int.parse(ipAddress.text));
          //               setState(() {
          //                 ipAddress.clear();
          //               });
          //             });
          //           });
          //         }),
          //         SizedBox(height: 15,),
          //         armButton(context, thirdPalette2, "Takibi bırak", 230, 60, () async {
          //           setState(() async {
          //             showAlertDialog(context, "Takibi bırak","${widget.targetString} numaralı aracın takibini bırakmak istediğinize emin misiniz?","${widget.targetString} numaralı aracın takibi bırakıldı!",Colors.green, () async {
          //               await RemoteService().sendTargetNumber(999);
          //             });
          //           });
          //         }),
          //         // accounts(context,"Ssh Ip Adresi","Ssh Şifre"),
          //         // SizedBox(height: 40,),
          //         // accounts(context,"API Ip Adresi","API Key" ),
          //
          //       ],
          //     ),
          //   ],
          // ),
        )
    );
  }
}