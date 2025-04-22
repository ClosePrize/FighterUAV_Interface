import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../remoteService.dart';

Color backgroundColor = Colors.red;

InkWell armButton(context, Color buttonColor, String title, double width, double height,Function func) {
  double density = 0.7;
  Color gradient = buttonColor.withOpacity(density);

  return InkWell(
    focusColor: Colors.grey,
    hoverColor: Colors.grey,
    splashColor: Colors.grey,
    highlightColor: Colors.grey,
    onTap: () {
      //showSnackBar(context);
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
          // Image.asset("assets/kamikaze.png",width: 100,height: 100,),
          // Image(image: AssetImage("assets/landing.png"),width: 100,height: 100,),
          Text(
            title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

InkWell modeButton(context, Color buttonColor, String title, double width, double height, String description, String snackBarDescription, Color color,Function func) {
  double density = 0.7;
  Color gradient = buttonColor.withOpacity(density);

  return InkWell(
    focusColor: Colors.grey,
    hoverColor: Colors.grey,
    splashColor: Colors.grey,
    highlightColor: Colors.grey,
    onTap: () {
      //showSnackBar(context);
      showAlertDialog(context, title,description,snackBarDescription,color,(){});
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
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

void showSnackBar(BuildContext context, String title, String description, Color color) {
  backgroundColor = color;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(description),
    ),
  );
}

void showAlertDialog(BuildContext context, String title, String description, String snackBarDescription, Color color, Function func) {
  int asd;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Uyarı'),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              asd = await func();
              print("bu da asd ${asd}");
              if(asd == 201 || asd == 200){
                showSnackBar(context, title, snackBarDescription, color);
              }
              else {
                showSnackBar(context, title, snackBarDescription, Colors.orange);
              }
            },
            child: Text('Tamam'),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text("İptal", style: TextStyle(color: Colors.red),))
        ],
      );
    },
  );
}

void showAlertDialogforChangeAltitude(BuildContext context, String title, String description, String snackBarDescription, Color color, Function func) {
  int asd;
  int sad;
  final password = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Uyarı'),
        content: Container(
          height: 100,
          width: 300,
          child: Column(
            children: [
              Text("Değiştirmek istediğiniz yükseklik verisini giriniz!"),
              TextField(
                controller: password,
                //cursorHeight: 15,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              asd = await RemoteService().sendModeForCommand(context, 6);
              await Future.delayed(const Duration(seconds: 1));
              sad = await RemoteService().sendChangeAltitudeInf(double.parse(password.text));
              if((asd == 201 || asd == 200) && (sad == 201 || sad == 200)){
                showSnackBar(context, title, snackBarDescription, color);
              }
              else {
                showSnackBar(context, title, snackBarDescription, Colors.orange);
              }
            },
            child: Text('Tamam'),
          ),
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("İptal", style: TextStyle(color: Colors.red),))
        ],
      );
    },
  );
}

void showRadioButton(BuildContext context, String title, String snackBarDescription, Color color, int selectedValue,Function func) {
  int asd;
  int _selectedValue = 1; // Initial selected value

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Algoritma ve Konum Seç!'),
        content: Container(color: Colors.red,height: 200,width: 200,
        child: Column(
          children: <Widget>[
            RadioListTile<int>(
              title: Text('Option 1'),
              value: 1,
              groupValue: _selectedValue,
              onChanged: (int? value) {
                _selectedValue = value!;
                func;
              },
            ),
            RadioListTile<int>(
              title: Text('Option 2'),
              value: 2,
              groupValue: _selectedValue,
              onChanged: (int? value) {
                _selectedValue = value!;
                func;
              },
            ),
          ],
        ),),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              asd = await func();
              print("bu da asd ${asd}");
              if(asd == 201 || asd == 200){
                showSnackBar(context, title, snackBarDescription, color);
              }
              else {
                showSnackBar(context, title, snackBarDescription, Colors.orange);
              }
            },
            child: Text('Gönder'),
          ),
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("İptal", style: TextStyle(color: Colors.red),))
        ],
      );
    },
  );
}