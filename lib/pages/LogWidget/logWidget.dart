import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savasan_interface_2024/colors.dart';
import 'package:savasan_interface_2024/pages/AccountsWidget/widgets.dart';
import 'package:savasan_interface_2024/pages/LogWidget/widgets.dart';

class LogInf extends StatefulWidget{
  final logs;
  const LogInf({super.key, required this.logs});

  @override
  State<LogInf> createState() => _LogInfState();
}

class _LogInfState extends State<LogInf> {
  late ScrollController _scrollController;
  var logLenght = 0;


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        didUpdateWidget(LogInf(logs: widget.logs));
        // print(modeString);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void didUpdateWidget(covariant LogInf oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.logs.length != widget.logs.length) {
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            width: MediaQuery.of(context).size.width/4,
            decoration: BoxDecoration(
              color: thirdPalette3,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
              ),
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Flexible(
                flex: 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    logBox(context,"10:57:56", "Guided moda alındı."),
                    logBox(context,"10:58:14", "Arm edildi."),
                    logBox(context,"10:58:34", "Araç 30 metre kalkış komutu verildi."),
                    logBox(context,"10:59:03", "Araç 30 metreye ulaştı."),
                    logBox(context,"10:59:10", "Araç (40.98923,28.72541) konumuna doğru yola çıktı."),
                    logBox(context,"11:00:41", "Araç hedefe ulaştı."),
                    logBox(context,"11:00:46", "Araç Land moda alındı."),
                    logBox(context,"11:01:57", "Araç iniş yaptı."),
                    logBox(context,"11:02:02", "Araç disarm edildi."),

                  ],
                ),
                // child:ListView.builder(
                //   itemCount: 10,
                //   itemBuilder: (context,index){
                //     return logBox(context,"10:57:56", "Arm edildi.");
                //   },
                // ),
              ),*/
              Flexible(
                flex: 9,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.logs.length,
                  itemBuilder: (BuildContext context, int index){
                    return logBox(context,"${widget.logs[index].saat}:${widget.logs[index].dakika}:${widget.logs[index].saniye}", widget.logs[index].log);
                  },
                )
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    detailButton(context, thirdPalette1, "Detay", 100, 40  , widget.logs)
                  ],
                ),
              )
            ],
          ),
        ),
        ),
      ],
    );
    /*return SingleChildScrollView(
      child: logLenght == 0
        ? Center(child: Text("Aktif log yok. "))
          :Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: Center(

        ),
      ),
    );*/
  }
}