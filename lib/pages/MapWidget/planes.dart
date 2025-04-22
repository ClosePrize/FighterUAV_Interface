import 'dart:convert';

  /*Planes parsePlaneInformation(String str) =>
    List<Planes>.from(json.decode(str).map((x) => Planes.fromJson(x)));*/

Planes PlanesFromJson(String str) {
  final parsed = json.decode(str);
  final itemsList = parsed['konumBilgileri'];

  List<KonumBilgileri> data = [];
  if (itemsList != null && itemsList.isNotEmpty) {
    data = (itemsList as List<dynamic>)
        .map((item) => KonumBilgileri.fromJson(item))
        .toList();
  } else {
    data = [];
  }

  return Planes(
    sunucuSaati: parsed['sunucuSaati'],
    konumBilgileri: data,
  );
}

String PlanesToJson(Planes data) => json.encode(data.toJson());
SunucuSaati a = SunucuSaati(saat: 0, dakika: 0, saniye: 0, milisaniye: 0);

class Planes {
  SunucuSaati sunucuSaati;
  List<KonumBilgileri> konumBilgileri;

  Planes({
    required this.sunucuSaati,
    this.konumBilgileri = const [],
  });
  factory Planes.fromJson(Map<String, dynamic> json) => Planes(
    sunucuSaati: json["sunucuSaati"] != null
        ? SunucuSaati.fromJson(json["sunucuSaati"])
    : SunucuSaati(),
    konumBilgileri: json["konumBilgileri"] != null
      ? List<KonumBilgileri>.from(json["konumBilgileri"].map((e) => KonumBilgileri.fromJson(e)))
    : [],
  );
  Map<String, dynamic> toJson() => {
    "sunucuSaati": sunucuSaati.toJson(),
    "konumBilgileri": List<dynamic>.from(konumBilgileri.map((x) => x.toJson())),
  };
}

class KonumBilgileri {
  int id;
  double lat;
  double lon;
  double alt;
  double pitch;
  double yaw;
  double roll;
  //double airspeed;
  //int time;

  KonumBilgileri({
    required this.id,
    required this.lat,
    required this.lon,
    required this.alt,
    required this.pitch,
    required this.yaw,
    required this.roll,
    //required this.airspeed,
    //required this.time,
  });

  factory KonumBilgileri.fromJson(Map<String, dynamic> json) => KonumBilgileri(
    id: json["takim_numarasi"],
    lat: (json["iha_enlem"]).toDouble(),
    lon: (json["iha_boylam"]).toDouble(),
    alt: (json["iha_irtifa"]).toDouble(),
    pitch: (json["iha_dikilme"]).toDouble(),
    yaw: json["iha_yonelme"].toDouble(),
    roll: json["iha_yatis"].toDouble(),
    //airspeed: json["iha_hizi"],
    //time: json["zaman_farki"],
  );

  Map<String, dynamic> toJson() => {
    "takim_numarasi": id,
    "iha_enlem": lat,
    "iha_boylam": lon,
    "iha_irtifa": alt,
    "iha_dikilme": pitch,
    "iha_yonelme": yaw,
    "iha_yatis": roll,
    //"iha_hizi": airspeed,
    //"zaman_farki": time,
  };
}

class SunucuSaati {
  int saat;
  int dakika;
  int saniye;
  int milisaniye;

  SunucuSaati({
    this.saat = 0,
    this.dakika = 0,
    this.saniye = 0,
    this.milisaniye = 0,
  });

  factory SunucuSaati.fromJson(Map<String, dynamic> json) => SunucuSaati(
    saat: json["saat"],
    dakika: json["dakika"],
    saniye: json["saniye"],
    milisaniye: json["milisaniye"],
  );

  Map<String, dynamic> toJson() => {
    "saat": saat,
    "dakika": dakika,
    "saniye": saniye,
    "milisaniye": milisaniye,
  };
}
