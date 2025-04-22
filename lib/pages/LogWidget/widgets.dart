import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../TelemetriWidget/telemetry.dart';

Container logBox (context,String time,String title){
  return Container(
    child: RichText(
      text: TextSpan(
        text: "",
        style: TextStyle(
          fontSize: 20,
        ),
        children: <TextSpan>[
          TextSpan(text: time, style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black)),
          TextSpan(text: "  ${title}", style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black)),
        ],
      ),
    ),
  );
}

InkWell detailButton(context, Color buttonColor, String title, double width, double height, List<LogModel> logs) {
  double density = 0.7;
  Color gradient = buttonColor.withOpacity(density);

  return InkWell(
    focusColor: Colors.grey,
    hoverColor: Colors.grey,
    splashColor: Colors.grey,
    highlightColor: Colors.grey,
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Log Geçmişi'),
            content: Container(
              height: 200,
              width: 500,
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (BuildContext context, int index){
                  return logBox(context,"${logs[index].saat}:${logs[index].dakika}:${logs[index].saniye}", logs[index].log);
                },
              )
            ),
            actions: [
              TextButton(
                child: Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            buttonColor,
            gradient,
          ],
        ),
        //color: buttonColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}