import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container modWidget (context, Color color,String mode){
  return Container(
    height: MediaQuery.of(context).size.height/30,
    //width: MediaQuery.of(context).size.width/15,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Color.fromARGB(200, 96, 93, 93),
          Color.fromARGB(200, 161, 157, 157),
        ],
      )
    ),
    child: Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Text(mode,style: TextStyle(fontSize: 18, ),),
      ),
    )
  );
}

Container telemetriHealthWidget (context, Color color,double health){
  double health_percent = health/100;
  return Container(
      height: MediaQuery.of(context).size.height/30,
      width: MediaQuery.of(context).size.width/15,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(180, 44, 239, 0),
              Color.fromARGB(180, 255, 0, 0),
            ],
            stops: [health_percent, (1-health_percent)],
          )
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text("%${health}",style: TextStyle(fontSize: 18, ),),
        ),
      )
  );
}

Container appBarInformationWidget (context, String data,bool isBool, Color color,bool isTrue){
  return Container(
      height: MediaQuery.of(context).size.height/30,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(200, 96, 93, 93),
              Color.fromARGB(200, 161, 157, 157),
            ],
          )
      ),
      child: isBool == true ? Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: isTrue == true ?
          Row(
            children: [
              Text(data ,style: TextStyle(fontSize: 22, ),),
              Icon(Icons.check)
            ],
          ): Row(
            children: [
              Text(data ,style: TextStyle(fontSize: 22, ),),
              Icon(Icons.close)
            ],
          )
        ),
      ):
      Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            children: [
              Text(data, style: TextStyle(fontSize: 22),)
            ],
          ),
        ),
      )
  );
}