import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Column textWidget (context,int parameterCount,String title, String param1, String param2, String param3, String param4, String param5,double value1,double value2,double value3){
  List<String> list = [param1,param2,param3,param4,param5];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      Container(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Container(
          //width: MediaQuery.of(context).size.width/8,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    param1 + ": ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    param2 + ": ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    param3 + ": ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start  ,
                children: [
                  /*ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        list[index] + ": ",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      );
                    }
                  ),*/
                  Text(
                    "${value1}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${value2}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${value3}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}

Column vfrWidget (context,int parameterCount,String title, String param1, String param2, String param3, String param4, String param5,double value1,double value2,double value3,double value4,double value5){
  List<String> list = [param1,param2,param3,param4,param5];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      Container(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Container(
          //width: MediaQuery.of(context).size.width/8,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    param1 + ": ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    param2 + ": ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    param3 + ": ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    param4 + ": ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    param5 + ": ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start  ,
                children: [
                  /*ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        list[index] + ": ",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      );
                    }
                  ),*/
                  Text(
                    "${value1}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${value2}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${value3}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${value4}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${value5}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}

Container infoButton (){
  return Container(
    height: 15,
    width: 30,
  );
}