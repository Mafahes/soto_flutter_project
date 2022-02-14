// @dart=2.9
// To parse this JSON data, do
//
//     final self = selfFromJson(jsonString);

import 'dart:convert';

Self selfFromJson(String str) => Self.fromJson(json.decode(str));

String selfToJson(Self data) => json.encode(data.toJson());

class Self {
  Self({
    this.nummer,
    this.dateBirt,
    this.secondName,
    this.firstName,
    this.patronymic,
    this.sex,
    this.dateBirth,
    this.description,
    this.city,
    this.version,
    this.isDeleted,
    this.lastLogin,
    this.isOnline,
    this.roleName,
    this.lockoutEnabled,
    this.uid,
    this.longitude,
    this.latitude,
    this.timestamp,
    this.accuracy,
    this.altitude,
    this.floor,
    this.heading,
    this.speed,
    this.speedAccuracy,
    this.isMocked,
    this.inits,
    this.state,
    this.email,
  });

  int nummer;
  dynamic dateBirt;
  String secondName;
  String firstName;
  String patronymic;
  dynamic sex;
  DateTime dateBirth;
  dynamic description;
  dynamic city;
  String version;
  bool isDeleted;
  DateTime lastLogin;
  bool isOnline;
  String roleName;
  bool lockoutEnabled;
  String uid;
  double longitude;
  double latitude;
  int timestamp;
  double accuracy;
  double altitude;
  double floor;
  double heading;
  double speed;
  dynamic speedAccuracy;
  dynamic isMocked;
  String inits;
  int state;
  String email;

  Self copyWith({
    int nummer,
    dynamic dateBirt,
    String secondName,
    String firstName,
    String patronymic,
    dynamic sex,
    DateTime dateBirth,
    dynamic description,
    dynamic city,
    String version,
    bool isDeleted,
    DateTime lastLogin,
    bool isOnline,
    String roleName,
    bool lockoutEnabled,
    String uid,
    double longitude,
    double latitude,
    int timestamp,
    double accuracy,
    double altitude,
    double floor,
    double heading,
    double speed,
    dynamic speedAccuracy,
    dynamic isMocked,
    String inits,
    int state,
    String email,
  }) =>
      Self(
        nummer: nummer ?? this.nummer,
        dateBirt: dateBirt ?? this.dateBirt,
        secondName: secondName ?? this.secondName,
        firstName: firstName ?? this.firstName,
        patronymic: patronymic ?? this.patronymic,
        sex: sex ?? this.sex,
        dateBirth: dateBirth ?? this.dateBirth,
        description: description ?? this.description,
        city: city ?? this.city,
        version: version ?? this.version,
        isDeleted: isDeleted ?? this.isDeleted,
        lastLogin: lastLogin ?? this.lastLogin,
        isOnline: isOnline ?? this.isOnline,
        roleName: roleName ?? this.roleName,
        lockoutEnabled: lockoutEnabled ?? this.lockoutEnabled,
        uid: uid ?? this.uid,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        timestamp: timestamp ?? this.timestamp,
        accuracy: accuracy ?? this.accuracy,
        altitude: altitude ?? this.altitude,
        floor: floor ?? this.floor,
        heading: heading ?? this.heading,
        speed: speed ?? this.speed,
        speedAccuracy: speedAccuracy ?? this.speedAccuracy,
        isMocked: isMocked ?? this.isMocked,
        inits: inits ?? this.inits,
        state: state ?? this.state,
        email: email ?? this.email,
      );

  factory Self.fromJson(Map<String, dynamic> json) => Self(
    nummer: json["nummer"] == null ? null : json["nummer"],
    dateBirt: json["dateBirt"],
    secondName: json["secondName"] == null ? null : json["secondName"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    patronymic: json["patronymic"] == null ? null : json["patronymic"],
    sex: json["sex"],
    dateBirth: json["dateBirth"] == null ? null : DateTime.parse(json["dateBirth"]),
    description: json["description"],
    city: json["city"],
    version: json["version"] == null ? null : json["version"],
    isDeleted: json["isDeleted"] == null ? null : json["isDeleted"],
    lastLogin: json["lastLogin"] == null ? null : DateTime.parse(json["lastLogin"]),
    isOnline: json["isOnline"] == null ? null : json["isOnline"],
    roleName: json["roleName"] == null ? null : json["roleName"],
    lockoutEnabled: json["lockoutEnabled"] == null ? null : json["lockoutEnabled"],
    uid: json["uid"] == null ? null : json["uid"],
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    timestamp: json["timestamp"] == null ? null : json["timestamp"],
    accuracy: json["accuracy"] == null ? null : json["accuracy"].toDouble(),
    altitude: json["altitude"] == null ? null : json["altitude"].toDouble(),
    floor: json["floor"] == null ? null : json["floor"].toDouble(),
    heading: json["heading"] == null ? null : json["heading"].toDouble(),
    speed: json["speed"] == null ? null : json["speed"].toDouble(),
    speedAccuracy: json["speedAccuracy"],
    isMocked: json["isMocked"],
    inits: json["inits"] == null ? null : json["inits"],
    state: json["state"] == null ? null : json["state"],
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "nummer": nummer == null ? null : nummer,
    "dateBirt": dateBirt,
    "secondName": secondName == null ? null : secondName,
    "firstName": firstName == null ? null : firstName,
    "patronymic": patronymic == null ? null : patronymic,
    "sex": sex,
    "dateBirth": dateBirth == null ? null : dateBirth.toIso8601String(),
    "description": description,
    "city": city,
    "version": version == null ? null : version,
    "isDeleted": isDeleted == null ? null : isDeleted,
    "lastLogin": lastLogin == null ? null : lastLogin.toIso8601String(),
    "isOnline": isOnline == null ? null : isOnline,
    "roleName": roleName == null ? null : roleName,
    "lockoutEnabled": lockoutEnabled == null ? null : lockoutEnabled,
    "uid": uid == null ? null : uid,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "timestamp": timestamp == null ? null : timestamp,
    "accuracy": accuracy == null ? null : accuracy,
    "altitude": altitude == null ? null : altitude,
    "floor": floor == null ? null : floor,
    "heading": heading == null ? null : heading,
    "speed": speed == null ? null : speed,
    "speedAccuracy": speedAccuracy,
    "isMocked": isMocked,
    "inits": inits == null ? null : inits,
    "state": state == null ? null : state,
    "email": email == null ? null : email,
  };
}
