import 'package:flutter/material.dart';
import 'package:savasan_interface_2024/colors.dart';

import '../CommandsWidget/widgets.dart';

InkWell connectButton(context, Color buttonColor, String title, double width, double height, Function func) {
  double density = 0.7;
  Color gradient = buttonColor.withOpacity(density);

  return InkWell(
    focusColor: Colors.grey,
    hoverColor: Colors.grey,
    splashColor: Colors.grey,
    highlightColor: Colors.grey,
    onTap: () {
      func();
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

Column accounts (context,String text1, String text2){
  final ipAddress = TextEditingController();
  final password = TextEditingController();
  return Column(
    children: [
      Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                  text1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
        ],
      ),
      SizedBox(height: 10,),
      Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                text2,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 150,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  //cursorHeight: 15,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 10,),
      Row(
        children: [
          connectButton(context, thirdPalette1, "Bağlan", 100, 40, (){
            print(ipAddress.text);
            print(password.text);
          }),
        ],
      ),
    ],
  );
}