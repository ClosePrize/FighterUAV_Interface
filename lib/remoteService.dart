import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:savasan_interface_2024/pages/CommandsWidget/commandModels.dart';
import 'package:savasan_interface_2024/pages/CommandsWidget/widgets.dart';
import 'package:savasan_interface_2024/pages/MapWidget/hss.dart';
import 'package:savasan_interface_2024/pages/TelemetriWidget/telemetry.dart';
import 'dataConstants.dart';
import 'dart:convert';

import 'pages/MapWidget/planes.dart';

class RemoteService {
  Future<Telemetry> getPlaneTelemetry() async {
    var client = http.Client();
    var uri = Uri.parse(apiAddressForTelemetry);
    var response = await client.get(uri);
    print("remote Service çalıştı");
    //if (response.statusCode == 200) {
    if(response.statusCode == 200){
      print("bilgi almış");
      // print(json.decode(response.body));
    }
    return Telemetry.fromJson(json.decode(response.body));
    //}
    //return null;
  }

  Future<Planes> getEnemyPlaneTelemetry() async {
    var client = http.Client();
    var uri = Uri.parse(apiAddressForIhaBilgileri);
    var response = await client.get(uri);
    print("remote Service çalıştı");
    //if (response.statusCode == 200) {
    if(response.statusCode == 200){
      print("bilgi almış");
    }
    return Planes.fromJson(json.decode(response.body));
    //}
  }

  Future<int> sendModeInf(bool isGuided,bool isAuto,bool isLand, bool isFBWA) async {
    Mods mod = Mods(guided: isGuided, auto: isAuto, land: isLand,fbwa:isFBWA);
    var response = await http.post(Uri.parse(apiAddressForModes),
        headers: {"Content-type": "application/json"},
        body: json.encode(mod.toJson()));
    if(response.statusCode == 500){
      print("bu response ${response.statusCode}");
      return response.statusCode;
    }
    else{
      return response.statusCode;
    }
  }

  Future<int> NewsendModeInf(int modeNumber) async {
    Mods123 mod = Mods123(mode: modeNumber);
    var response = await http.post(Uri.parse(apiAddressForModes),
        headers: {"Content-type": "application/json"},
        body: json.encode(mod.toJson()));
    if(response.statusCode == 500){
      print("bu response ${response.statusCode}");
      return response.statusCode;
    }
    else{
      return response.statusCode;
    }
  }

  Future<int> sendModeForCommand(context, int mode) async {
    ModeForCommand mod = ModeForCommand(modeForCommand: mode);
    var response = await http.post(Uri.parse(apiAddressForModeCommand),
        headers: {"Content-type": "application/json"},
        body: json.encode(mod.toJson()));
    if(response.statusCode == 500 && mode == 0){
      // showAlertDialog(context, "Takeoff","Aracı Takeoff moda almak istediğinize emin misiniz?","Araç Takeoff moda alındı!",Colors.green);
      return response.statusCode;
    }
    else if(response.statusCode == 500 && mode == 1){
      // showAlertDialog(context, "Reset Target","Araca Reset Target vermek istediğinize emin misiniz?", "Aracın hedefi sıfırlandı!",Colors.green);
      return response.statusCode;
    }
    else if(response.statusCode == 500 && mode == 2){
      // showAlertDialog(context, "Otonom Takip", "Aracı Otonom Takip moduna almak istediğinize emin misiniz?", "Araç Otonom Takip moduna alındı!",Colors.green);
      return response.statusCode;
    }
    else if(response.statusCode == 500 && mode == 3){
      // showAlertDialog(context, "Kamikaze", "Aracı Guided moda almak istediğinize emin misiniz?", "Araç Guided moda alındı!",Colors.green);
      return response.statusCode;
    }
    else{
      return response.statusCode;
    }
  }

  Future<int> sendArmInf(bool isArmed) async {
    Arm arm = Arm(arm: isArmed);
    var response = await http.post(Uri.parse(apiAddressForArm),
        headers: {"Content-type": "application/json"},
        body: json.encode(arm.toJson()));
    // print(response.body);
    if(response.statusCode == 201){
      print("bu response ${response.statusCode}");
      return response.statusCode;
    }
    else{
      print("bu response ${response.statusCode}");

      return response.statusCode;
    }
  }

  Future<int> sendChangeAltitudeInf(double altitudeInf) async {
    Altitude altitude = Altitude(altitude: altitudeInf);
    var response = await http.post(Uri.parse(apiAddressForChangeAltitude),
        headers: {"Content-type": "application/json"},
        body: json.encode(altitude.toJson()));
    // print(response.body);
    if(response.statusCode == 500){
      return response.statusCode;
    }
    else{
      return response.statusCode;
    }
  }

  Future<int> sendKamikazeInf(bool kamikazeInf) async {
    Kamikaze kamikaze = Kamikaze(kamikaze: kamikazeInf);
    var response = await http.post(Uri.parse(apiAddressForArm),
        headers: {"Content-type": "application/json"},
        body: json.encode(kamikaze.toJson()));
    // print(response.body);
    if(response.statusCode == 500){
      return response.statusCode;
    }
    else{
      return response.statusCode;
    }
  }

  Future<int> sendResetTargetInf(bool targetInf) async {
    ResetTarget resetTarget = ResetTarget(target: targetInf);
    var response = await http.post(Uri.parse(apiAddressForResetTarget),
        headers: {"Content-type": "application/json"},
        body: json.encode(resetTarget.toJson()));
    // print(response.body);
    if(response.statusCode == 500){
      return response.statusCode;
    }
    else{
      return response.statusCode;
    }
  }

  Future<int> sendOtonomTakipInf(bool takipInf) async {
    OtonomTakip otonomTakip = OtonomTakip(takip: takipInf);
    var response = await http.post(Uri.parse(apiAddressForResetTarget),
        headers: {"Content-type": "application/json"},
        body: json.encode(otonomTakip.toJson()));
    // print(response.body);
    if(response.statusCode == 500){
      return response.statusCode;
    }
    else{
      return response.statusCode;
    }
  }
  Future<int> sendTargetNumber(int targetNumber) async {
    Hedef mod = Hedef(manuelHedef: targetNumber);
    var response = await http.post(Uri.parse(apiAddressForManuelTargetNumber),
        headers: {"Content-type": "application/json"},
        body: json.encode(mod.toJson()));
    if(response.statusCode == 500){
      return response.statusCode;
    }
    else{
      return response.statusCode;
    }
  }

  Future<int> getHedefInf() async {
    var client = http.Client();
    var uri = Uri.parse(apiAddressForTargetNumber);
    var response = await client.get(uri);
    //if (response.statusCode == 200) {
    if(response.statusCode == 200){
      print(response.body);
    }
    return int.parse(response.body);
    //}
  }

  Future<int> getManuelHedefInf() async {
    var client = http.Client();
    var uri = Uri.parse(apiAddressForManuelTargetNumber);
    var response = await client.get(uri);
    //if (response.statusCode == 200) {
    if(response.statusCode == 200){
      print(response.body);
    }
    return int.parse(response.body);
    //}
  }

  Future<int> getModeInf() async {
    var client = http.Client();
    var uri = Uri.parse(apiAddressForModeCommand);
    var response = await client.get(uri);
    //if (response.statusCode == 200) {
    if(response.statusCode == 200){
      print(response.body);
    }
    return int.parse(response.body);
    //}
  }

  Future<QrInf> getQrInf() async {
    var client = http.Client();
    var uri = Uri.parse(apiAddressForQrCoordinate);
    var response = await client.get(uri);
    print("remote Service çalıştı");
    //if (response.statusCode == 200) {
    if(response.statusCode == 200){
      print("bilgi almış");
      // print(json.decode(response.body));
    }
    return QrInf.fromJson(json.decode(response.body));
    //}
    //return null;
  }

  Future<List<HssBilgileri>> fetchHssBilgileri() async {
    final response = await http.get(Uri.parse('http://10.0.0.71:8000/iha/hss'));

    if (response.statusCode == 200) {
      // Parse the JSON
      List<dynamic> jsonList = jsonDecode(response.body);

      // Convert to List<HssBilgileri>
      return jsonList.map((json) => HssBilgileri.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Hss Bilgileri');
    }
  }
}