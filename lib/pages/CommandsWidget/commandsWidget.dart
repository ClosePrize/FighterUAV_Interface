import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savasan_interface_2024/colors.dart';
import 'package:savasan_interface_2024/pages/AccountsWidget/widgets.dart';
import 'package:savasan_interface_2024/pages/CommandsWidget/widgets.dart';
import '../../remoteService.dart';

class Commands extends StatefulWidget{
  const Commands({super.key});

  @override
  State<Commands> createState() => _CommandsState();
}
enum SingingCharacter { lafayette, jefferson }

enum Groceries { pickles, tomato, lettuce }

class _CommandsState extends State<Commands>{
  int selectedRadio = 1;
  int asd = 0;
  int _selectedValue = 1;
  SingingCharacter? _character = SingingCharacter.lafayette;
  Groceries? _groceryItem = Groceries.pickles;
  double density = 0.7;
  Color gradient = Colors.grey.withOpacity(0.7);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: MediaQuery.of(context).size.width/1.2 - (MediaQuery.of(context).size.width/4 +16),
      decoration: const BoxDecoration(
        color: thirdPalette3,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(width: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Modlar:",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: Colors.transparent
                ),
              ),
              SizedBox(height: 20,),
              armButton(context, thirdPalette1, "ARM", 200, 90,()async{
                setState(() async {
                   showAlertDialog(context, "ARM", "Aracı ARM etmek istediğinize emin misiniz?", "Araç ARM edildi!",Colors.green,() async {
                     return await RemoteService().sendArmInf(true);
                   });
                });
              }),
              SizedBox(height: 25),
              armButton(context, thirdPalette4, "DİSARM",200, 90, ()async{
                setState(() async {
                  showAlertDialog(context, "DİSARM", "Aracı DISARM etmek istediğinize emin misiniz?", "Araç DISARM edildi!",Colors.red,() async {
                    return await RemoteService().sendArmInf(false);
                  });
                });
              }),
              SizedBox(height: 20,),
              armButton(context, thirdPalette2, "Land", 200, 60, () async {
                setState(() async {
                  showAlertDialog(context,"Land", "Aracı Land moda almak istediğinize emin misiniz?", "Araç Land moda alındı!",Colors.green,() async {
                    await RemoteService().sendModeInf(false, false, true, false);
                    return await RemoteService().sendModeForCommand(context, 4);
                  });
                });
              }),
            ],
          ),
          SizedBox(width: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Modlar:",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 20,),
              armButton(context, thirdPalette2, "Loiter", 230, 60, () async {
                setState(() async {
                  showAlertDialog(context,"Idle", "Aracı Idle moda almak istediğinize emin misiniz?", "Araç Idle moda alındı!",Colors.green,() async {
                    return await RemoteService().sendModeForCommand(context, 5);
                  });
                });
              }),
              SizedBox(height: 15,),
              armButton(context, thirdPalette2, "Guided", 230, 60, () async {
                setState(() async {
                  showAlertDialog(context, "Guided","Aracı Guided moda almak istediğinize emin misiniz?", "Araç Guided moda alındı!",Colors.green,() async {
                    return await RemoteService().sendModeForCommand(context, 6);
                  });
                });
              }),
              SizedBox(height: 15,),
              armButton(context, thirdPalette2, "Auto", 230, 60, () async {
                setState(() async {
                  showAlertDialog(context, "Auto","Aracı Auto moda almak istediğinize emin misiniz?","Araç Auto moda alındı!",Colors.orange,() async {
                    return await RemoteService().sendModeForCommand(context, 7);
                  });
                });
              }),
              SizedBox(height: 15,),
              armButton(context, thirdPalette2, "FBWA", 230, 60, () async {
                setState(() async {
                  showAlertDialog(context,"FBWA", "Aracı FBWA moda almak istediğinize emin misiniz?", "Araç FBWA moda alındı!",Colors.green,() async {
                    return await RemoteService().sendModeForCommand(context, 8);
                  });
                });
              }),
            ],
          ),
          SizedBox(width: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Komutlar:",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 20,),
              armButton(context, thirdPalette2, "Takeoff", 230, 60, () async {
                setState(() async {
                  showAlertDialog(context, "Takeoff","Aracı Takeoff moda almak istediğinize emin misiniz?","Araç Takeoff moda alındı!",Colors.green, () async {
                    return await RemoteService().sendModeForCommand(context, 0);
                  });
                });
              }),
              SizedBox(height: 15,),
              armButton(context, thirdPalette2, "Change Altitude", 230, 60, () async {
                setState(() async {
                  showAlertDialogforChangeAltitude(context, "Change Altitude", "Aracı yüksekliğini değiştirmek istediğinize emin misiniz?", "Aracın yüksekliği değiştirildi!",Colors.green, () async {
                    await RemoteService().sendModeForCommand(context, 6);
                    await Future.delayed(const Duration(seconds: 1));
                    return await RemoteService().sendChangeAltitudeInf(60.4);
                  });
                });
              }),
              SizedBox(height: 15,),
              armButton(context, thirdPalette2, "Search and Follow", 230, 60,(){
                setState(() async {
                  showAlertDialog(context, "Reset Target","Araca Search komutu vermek istediğinize emin misiniz?", "Aracın hedefi sıfırlandı!",Colors.green, () async {
                    return await RemoteService().sendModeForCommand(context, 1);
                  });
                });
              }),
              SizedBox(height: 15,),
              armButton(context, thirdPalette2, "Otonom Takip", 230, 60, ()async{
                setState(() async {
                  showAlertDialog(context, "Otonom Takip", "Aracı Otonom Takip moduna almak istediğinize emin misiniz?", "Araç Otonom Takip moduna alındı!",Colors.green, () async {
                    return await RemoteService().sendModeForCommand(context, 2);
                  });
                });
              }),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Komutlar:",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: Colors.transparent
                ),
              ),
              // SizedBox(height: 20,),
              // armButton(context, thirdPalette2, "Land", 230, 60, () async {
              //   setState(() async {
              //     showAlertDialog(context,"Land", "Aracı Land moda almak istediğinize emin misiniz?", "Araç Land moda alındı!",Colors.green,() async {
              //       await RemoteService().sendModeInf(false, false, true, false);
              //       return await RemoteService().sendModeForCommand(context, 4);
              //     });
              //   });
              // }),
              SizedBox(height: 20,),
              armButton(context, thirdPalette5, "Kamikaze", 230, 120, () async {
                setState(() async {
                  showAlertDialog(context, "Kamikaze", "Aracı Kamikaze moduna almak istediğinize emin misiniz?", "Araç Kamikaze moduna alındı!",thirdPalette5, () async {
                    return await RemoteService().sendModeForCommand(context, 3);
                  });
                });
              }),
              SizedBox(height: 20,),
              armButton(context, thirdPalette2, "RTL", 230, 60, () async {
                setState(() async {
                  showAlertDialog(context, "RTL", "Aracı RTL moduna almak istediğinize emin misiniz?", "Araç RTL moduna alındı!",thirdPalette5, () async {
                    return await RemoteService().sendModeForCommand(context, 9);
                  });
                });
              }),
              SizedBox(height: 20,),
              armButton(context, thirdPalette2, "Mission Planner", 230, 60, () async {
                print("Rtl");
                setState(() async {
                  showAlertDialog(context, "Control", "Aracı Control moduna almak istediğinize emin misiniz?", "Araç RTL moduna alındı!",thirdPalette5, () async {
                    return await RemoteService().sendModeForCommand(context, 10);
                  });
                });
              }),
              /*InkWell(
                child: Container(
                  width: 230  ,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        thirdPalette2,
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
                        "Algoritma/Konum",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                // setState(() async {
                //   showRadioButton(context,"Algoritma ve Konum", "Araç Idle moda alındı!",Colors.green,selectedRadio, () async {
                //     setState(() {
                //     });
                //   });
                // });
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    int? _tempSelectedValue = _selectedValue;
                    int algoritma = 1;
                    return AlertDialog(
                      title: Text('Algoritma ve Konum Seç!'),
                      content: Container(
                        color: Colors.red,
                        height: 420,
                        width: 200,
                        child: Column(
                          children: <Widget>[
                            RadioListTile<Groceries>(
                              value: Groceries.pickles,
                              groupValue: _groceryItem,
                              onChanged: (Groceries? value) {
                                setState(() {
                                  _groceryItem = value;
                                });
                              },
                              title: const Text('Pickles'),
                              subtitle: const Text('Supporting text'),
                            ),
                            RadioListTile<Groceries>(
                              value: Groceries.tomato,
                              groupValue: _groceryItem,
                              onChanged: (Groceries? value) {
                                setState(() {
                                  _groceryItem = value;
                                });
                              },
                              title: const Text('Tomato'),
                              subtitle: const Text(
                                  'Longer supporting text to demonstrate how the text wraps and the radio is centered vertically with the text.'),
                            ),
                            RadioListTile<Groceries>(
                              value: Groceries.lettuce,
                              groupValue: _groceryItem,
                              onChanged: (Groceries? value) {
                                setState(() {
                                  _groceryItem = value;
                                });
                              },
                              title: const Text('Lettuce'),
                              subtitle: const Text(
                                  "Longer supporting text to demonstrate how the text wraps and how setting 'RadioListTile.isThreeLine = true' aligns the radio to the top vertically with the text."),
                              isThreeLine: true,
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              _selectedValue = _tempSelectedValue!;
                            });
                            Navigator.of(context).pop();
                            print("Selected value: $_selectedValue");
                            // Add your additional logic here
                          },
                          child: Text('Gönder'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "İptal",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),*/
            ],
          )
        ],
      ),
    );
  }
}