// import 'dart:convert';
//
// /*Planes parsePlaneInformation(String str) =>
//     List<Planes>.from(json.decode(str).map((x) => Planes.fromJson(x)));*/
//
// HSS HSSFromJson(String str) {
//   final parsed = json.decode(str);
//   final itemsList = parsed['hsskoordinati'];
//
//   List<HSSBilgileri> data = [];
//   if (itemsList != null && itemsList.isNotEmpty) {
//     data = (itemsList as List<dynamic>)
//         .map((item) => HSSBilgileri.fromJson(item))
//         .toList();
//   } else {
//     data = [];
//   }
//
//   return HSS(
//     hssBilgileri: data,
//   );
// }
//
// String PlanesToJson(HSS data) => json.encode(data.toJson());
//
// class HSS {
//   List<HSSBilgileri> hssBilgileri;
//
//   HSS({
//     this.hssBilgileri = const [],
//   });
//   factory HSS.fromJson(Map<String, dynamic> json) => HSS(
//     hssBilgileri: json["hsskoordinati"] != null
//         ? List<HSSBilgileri>.from(json["hsskoordinati"].map((e) => HSSBilgileri.fromJson(e)))
//         : [],
//   );
//   Map<String, dynamic> toJson() => {
//     "hsskoordinati": List<dynamic>.from(hssBilgileri.map((x) => x.toJson())),
//   };
// }
//
// class HSSBilgileri {
//   int id;
//   double enlem;
//   double boylam;
//   int yaricap;
//
//   HSSBilgileri({
//     required this.id,
//     required this.enlem,
//     required this.boylam,
//     required this.yaricap,
//   });
//
//   factory HSSBilgileri.fromJson(Map<String, dynamic> json) => HSSBilgileri(
//     id: json["takim_numarasi"],
//     enlem: (json["iha_enlem"]).toDouble(),
//     boylam: (json["iha_boylam"]).toDouble(),
//     yaricap: (json["iha_irtifa"]).toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "takim_numarasi": id,
//     "iha_enlem": enlem,
//     "iha_boylam": boylam,
//     "iha_irtifa": yaricap,
//   };
// }
//

class HssBilgileri {
  final int id;
  final double hssEnlem;
  final double hssBoylam;
  final double hssYaricap;

  HssBilgileri({
    required this.id,
    required this.hssEnlem,
    required this.hssBoylam,
    required this.hssYaricap,
  });

  // Updated parsing to handle potential int-double mismatches
  factory HssBilgileri.fromJson(Map<String, dynamic> json) {
    return HssBilgileri(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()), // Ensure it's an int
      hssEnlem: (json['hssEnlem'] is int) ? (json['hssEnlem'] as int).toDouble() : json['hssEnlem'], // Convert int to double if necessary
      hssBoylam: (json['hssBoylam'] is int) ? (json['hssBoylam'] as int).toDouble() : json['hssBoylam'], // Convert int to double if necessary
      hssYaricap: (json['hssYaricap'] is int) ? (json['hssYaricap'] as int).toDouble() : json['hssYaricap'], // Convert int to double if necessary
    );
  }
}

