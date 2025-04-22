import 'dart:convert';

class Telemetry {
  double lat;
  double lon;
  double alt;
  double roll;
  double pitch;
  double yaw;
  double airspeed;
  double groundspeed;
  double heading;
  double throttle;
  double climb;
  double telemetriSagligi;
  bool isConnectedApi;
  String mode;
  List<Log> logs;

  Telemetry({
    required this.lat,
    required this.lon,
    required this.alt,
    required this.roll,
    required this.pitch,
    required this.yaw,
    required this.airspeed,
    required this.groundspeed,
    required this.heading,
    required this.throttle,
    required this.climb,
    required this.telemetriSagligi,
    required this.isConnectedApi,
    required this.mode,
    required this.logs,
  });
  factory Telemetry.fromJson(Map<String, dynamic> json) => Telemetry(
    lat: (json["lat"]).toDouble(),
    lon: (json["lon"]).toDouble(),
    alt: (json["alt"]).toDouble(),
    pitch: (json["pitch"]).toDouble(),
    yaw: (json["yaw"]).toDouble(),
    roll: (json["roll"]).toDouble(),
    airspeed: (json["airspeed"]).toDouble(),
    groundspeed: (json["groundspeed"]).toDouble(),
    heading: (json["heading"]).toDouble(),
    throttle: (json["throttle"]).toDouble(),
    climb: (json["climb"]).toDouble(),
    telemetriSagligi: (json["telemetriSagligi"]).toDouble(),
    isConnectedApi: json["isConnectedApi"],
    mode: json["mode"],
    logs: json["logs"] != null
        ? List<Log>.from(json["logs"].map((e) => Log.fromJson(e)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "alt": alt,
    "pitch": pitch,
    "yaw": yaw,
    "roll": roll,
    "airspeed": airspeed,
    "groundspeed": groundspeed,
    "heading": heading,
    "throttle": throttle,
    "climb": climb,
    "telemetriSagligi": telemetriSagligi,
    "isConnectedApi": isConnectedApi,
    "mode": mode,
    "logs": logs,
  };
}

class Log {
  int saat;
  int dakika;
  int saniye;
  String log;

  Log({
    required this.saat,
    required this.dakika,
    required this.saniye,
    required this.log,
  });
  factory Log.fromJson(Map<String, dynamic> json) => Log(
    saat: json["saat"],
    dakika: json["dakika"],
    saniye: json["saniye"],
    log: json["log"],
  );

  Map<String, dynamic> toJson() => {
    "saat": saat,
    "dakika": dakika,
    "saniye": saniye,
    "log": log,
  };
}

class LogModel {
  String saat;
  String dakika;
  String saniye;
  String log;

  LogModel({
    required this.saat,
    required this.dakika,
    required this.saniye,
    required this.log,
  });
  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
    saat: json["saat"],
    dakika: json["dakika"],
    saniye: json["saniye"],
    log: json["log"],
  );

  Map<String, dynamic> toJson() => {
    "saat": saat,
    "dakika": dakika,
    "saniye": saniye,
    "log": log,
  };
}
