
import 'dart:ffi';

class Arm{
  bool? arm;

  Arm({this.arm});

  factory Arm.fromJson(Map<String, dynamic> json) => Arm(
    arm: json["arm"],
  );

  Map<String, dynamic> toJson() => {
    "arm": arm,
  };
}

class Mods {
  bool? guided;
  bool? auto;
  bool? land;
  bool? fbwa;

  Mods({this.guided, this.auto, this.land, this.fbwa});

  factory Mods.fromJson(Map<String, dynamic> json) => Mods(
    guided: json["Guided"],
    auto: json["Auto"],
    land: json["Land"],
    fbwa: json["FBWA"],
  );

  Map<String, dynamic> toJson() => {
    "Guided": guided,
    "Auto": auto,
    "Land": land,
    "FBWA": fbwa,
  };
}

class Mods123 {
  int? mode;

  Mods123({this.mode});

  factory Mods123.fromJson(Map<String, dynamic> json) => Mods123(
    mode: json["Mode"],
  );

  Map<String, dynamic> toJson() => {
    "Mode": mode
  };
}

class Altitude{
  double? altitude;

  Altitude({this.altitude});

  factory Altitude.fromJson(Map<String, dynamic> json) => Altitude(
    altitude: json["alt"],
  );

  Map<String, dynamic> toJson() => {
    "alt": altitude,
  };
}

class ModeForCommand{
  int? modeForCommand;

  ModeForCommand({this.modeForCommand});

  factory ModeForCommand.fromJson(Map<String, dynamic> json) => ModeForCommand(
    modeForCommand: json["mode"],
  );

  Map<String, dynamic> toJson() => {
    "mode": modeForCommand,
  };
}

class Kamikaze{
  bool? kamikaze;

  Kamikaze({this.kamikaze});

  factory Kamikaze.fromJson(Map<String, dynamic> json) => Kamikaze(
    kamikaze: json["kamikaze"],
  );

  Map<String, dynamic> toJson() => {
    "kamikaze": kamikaze,
  };
}

class ResetTarget{
  bool? target;

  ResetTarget({this.target});

  factory ResetTarget.fromJson(Map<String, dynamic> json) => ResetTarget(
    target: json["reset"],
  );

  Map<String, dynamic> toJson() => {
    "reset": target,
  };
}

class OtonomTakip{
  bool? takip;

  OtonomTakip({this.takip});

  factory OtonomTakip.fromJson(Map<String, dynamic> json) => OtonomTakip(
    takip: json["takip"],
  );

  Map<String, dynamic> toJson() => {
    "takip": takip,
  };
}

class Hedef {
  int? manuelHedef;

  Hedef({required this.manuelHedef});

  factory Hedef.fromJson(Map<String, dynamic> json) => Hedef(
    manuelHedef: json["manuelHedef"],
  );

  Map<String, dynamic> toJson() => {
    "manuelHedef": manuelHedef
  };
}

class QrInf {
  double qrEnlem;
  double qrBoylam;

  QrInf({required this.qrEnlem, required this.qrBoylam});

  factory QrInf.fromJson(Map<String, dynamic> json) => QrInf(
    qrEnlem: json["qrEnlem"],
    qrBoylam: json["qrBoylam"],
  );

  Map<String, dynamic> toJson() => {
    "qrEnlem": qrEnlem,
    "qrBoylam": qrBoylam,
  };
}