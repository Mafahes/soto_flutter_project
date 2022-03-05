// To parse this JSON data, do
//
//     final orderById = orderByIdFromJson(jsonString);
// @dart=2.9

import 'dart:convert';

OrderById orderByIdFromJson(String str) => OrderById.fromJson(json.decode(str));

String orderByIdToJson(OrderById data) => json.encode(data.toJson());

class History {
  History({
    this.id,
    this.userId,
    this.orderId,
    this.order,
    this.orderIdHistory,
    this.orderInHistory,
    this.description,
    this.dateAdd,
    this.dateUpdate,
  });

  int id;
  String userId;
  int orderId;
  dynamic order;
  int orderIdHistory;
  OrderById orderInHistory;
  String description;
  DateTime dateAdd;
  DateTime dateUpdate;

  factory History.fromJson(Map<String, dynamic> json) => History(
    id: json["id"] == null ? null : json["id"],
    userId: json["userId"] == null ? null : json["userId"],
    orderId: json["orderId"] == null ? null : json["orderId"],
    order: json["order"],
    orderIdHistory: json["orderIdHistory"] == null ? null : json["orderIdHistory"],
    orderInHistory: json["orderInHistory"] == null ? null : OrderById.fromJson(json["orderInHistory"]),
    description: json["description"] == null ? null : json["description"],
    dateAdd: json["dateAdd"] == null ? null : DateTime.parse(json["dateAdd"]),
    dateUpdate: json["dateUpdate"] == null ? null : DateTime.parse(json["dateUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userId": userId == null ? null : userId,
    "orderId": orderId == null ? null : orderId,
    "order": order,
    "orderIdHistory": orderIdHistory == null ? null : orderIdHistory,
    "orderInHistory": orderInHistory == null ? null : orderInHistory.toJson(),
    "description": description == null ? null : description,
    "dateAdd": dateAdd == null ? null : dateAdd.toIso8601String(),
    "dateUpdate": dateUpdate == null ? null : dateUpdate.toIso8601String(),
  };
}

class OrderById {
  OrderById({
    this.id,
    this.user,
    this.brigadeId,
    this.brigade,
    this.secondName,
    this.firstName,
    this.patronymic,
    this.sex,
    this.age,
    this.deathId,
    this.number,
    this.address,
    this.longitude,
    this.latitude,
    this.longitudeMorg,
    this.latitudeMorg,
    this.addressMorgue,
    this.phoneContact,
    this.secondPhoneContact,
    this.cause,
    this.addInformation,
    this.dateDeath,
    this.state,
    this.isDelete,
    this.dateAdd,
    this.source,
    this.files,
    this.history,
  });

  int id;
  User user;
  int brigadeId;
  Brigade brigade;
  String secondName;
  String firstName;
  String patronymic;
  bool sex;
  int age;
  String deathId;
  String number;
  String address;
  dynamic longitude;
  dynamic latitude;
  double longitudeMorg;
  double latitudeMorg;
  String addressMorgue;
  String phoneContact;
  String secondPhoneContact;
  String cause;
  String addInformation;
  DateTime dateDeath;
  int state;
  bool isDelete;
  DateTime dateAdd;
  dynamic source;
  List<FileElement> files;
  List<History> history;

  factory OrderById.fromJson(Map<String, dynamic> json) => OrderById(
    id: json["id"] == null ? null : json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    brigadeId: json["brigadeId"] == null ? null : json["brigadeId"],
    brigade: json["brigade"] == null ? null : Brigade.fromJson(json["brigade"]),
    secondName: json["secondName"] == null ? null : json["secondName"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    patronymic: json["patronymic"] == null ? null : json["patronymic"],
    sex: json["sex"] == null ? null : json["sex"],
    age: json["age"] == null ? null : json["age"],
    deathId: json["deathId"] == null ? null : json["deathId"],
    number: json["number"] == null ? null : json["number"],
    address: json["address"] == null ? null : json["address"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    longitudeMorg: json["longitudeMorg"] == null ? null : json["longitudeMorg"].toDouble(),
    latitudeMorg: json["latitudeMorg"] == null ? null : json["latitudeMorg"].toDouble(),
    addressMorgue: json["addressMorgue"] == null ? null : json["addressMorgue"],
    phoneContact: json["phoneContact"] == null ? null : json["phoneContact"],
    secondPhoneContact: json["secondPhoneContact"] == null ? null : json["secondPhoneContact"],
    cause: json["cause"] == null ? null : json["cause"],
    addInformation: json["addInformation"] == null ? null : json["addInformation"],
    dateDeath: json["dateDeath"] == null ? null : DateTime.parse(json["dateDeath"]),
    state: json["state"] == null ? null : json["state"],
    isDelete: json["isDelete"] == null ? null : json["isDelete"],
    dateAdd: json["dateAdd"] == null ? null : DateTime.parse(json["dateAdd"]),
    source: json["source"],
    files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
    history: json["history"] == null ? null : List<History>.from(json["history"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user": user == null ? null : user.toJson(),
    "brigadeId": brigadeId == null ? null : brigadeId,
    "brigade": brigade == null ? null : brigade.toJson(),
    "secondName": secondName == null ? null : secondName,
    "firstName": firstName == null ? null : firstName,
    "patronymic": patronymic == null ? null : patronymic,
    "sex": sex == null ? null : sex,
    "age": age == null ? null : age,
    "deathId": deathId == null ? null : deathId,
    "number": number == null ? null : number,
    "address": address == null ? null : address,
    "longitude": longitude,
    "latitude": latitude,
    "longitudeMorg": longitudeMorg == null ? null : longitudeMorg,
    "latitudeMorg": latitudeMorg == null ? null : latitudeMorg,
    "addressMorgue": addressMorgue == null ? null : addressMorgue,
    "phoneContact": phoneContact == null ? null : phoneContact,
    "secondPhoneContact": secondPhoneContact == null ? null : secondPhoneContact,
    "cause": cause == null ? null : cause,
    "addInformation": addInformation == null ? null : addInformation,
    "dateDeath": dateDeath == null ? null : dateDeath.toIso8601String(),
    "state": state == null ? null : state,
    "isDelete": isDelete == null ? null : isDelete,
    "dateAdd": dateAdd == null ? null : dateAdd.toIso8601String(),
    "source": source,
    "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toJson())),
    "history": history == null ? null : List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

class Brigade {
  Brigade({
    this.state,
    this.id,
    this.uid,
    this.code,
    this.cause,
    this.autoId,
    this.car,
    this.drivers,
    this.medicals,
    this.freeSpaces,
    this.distance,
    this.longitude,
    this.latitude,
    this.heading,
  });

  int state;
  int id;
  String uid;
  String code;
  dynamic cause;
  int autoId;
  Car car;
  List<Driver> drivers;
  List<Driver> medicals;
  int freeSpaces;
  int distance;
  dynamic longitude;
  dynamic latitude;
  dynamic heading;

  factory Brigade.fromJson(Map<String, dynamic> json) => Brigade(
    state: json["state"] == null ? null : json["state"],
    id: json["id"] == null ? null : json["id"],
    uid: json["uid"] == null ? null : json["uid"],
    code: json["code"] == null ? null : json["code"],
    cause: json["cause"],
    autoId: json["autoId"] == null ? null : json["autoId"],
    car: json["car"] == null ? null : Car.fromJson(json["car"]),
    drivers: json["drivers"] == null ? null : List<Driver>.from(json["drivers"].map((x) => Driver.fromJson(x))),
    medicals: json["medicals"] == null ? null : List<Driver>.from(json["medicals"].map((x) => Driver.fromJson(x))),
    freeSpaces: json["freeSpaces"] == null ? null : json["freeSpaces"],
    distance: json["distance"] == null ? null : json["distance"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    heading: json["heading"],
  );

  Map<String, dynamic> toJson() => {
    "state": state == null ? null : state,
    "id": id == null ? null : id,
    "uid": uid == null ? null : uid,
    "code": code == null ? null : code,
    "cause": cause,
    "autoId": autoId == null ? null : autoId,
    "car": car == null ? null : car.toJson(),
    "drivers": drivers == null ? null : List<dynamic>.from(drivers.map((x) => x.toJson())),
    "medicals": medicals == null ? null : List<dynamic>.from(medicals.map((x) => x.toJson())),
    "freeSpaces": freeSpaces == null ? null : freeSpaces,
    "distance": distance == null ? null : distance,
    "longitude": longitude,
    "latitude": latitude,
    "heading": heading,
  };
}

class Car {
  Car({
    this.id,
    this.numberPlaces,
    this.user,
    this.uid,
    this.name,
    this.code,
    this.modelCarName,
    this.modelCarCode,
    this.typeCarName,
    this.typeCarDescription,
  });

  int id;
  int numberPlaces;
  dynamic user;
  String uid;
  String name;
  String code;
  String modelCarName;
  String modelCarCode;
  String typeCarName;
  String typeCarDescription;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"] == null ? null : json["id"],
    numberPlaces: json["numberPlaces"] == null ? null : json["numberPlaces"],
    user: json["user"],
    uid: json["uid"] == null ? null : json["uid"],
    name: json["name"] == null ? null : json["name"],
    code: json["code"] == null ? null : json["code"],
    modelCarName: json["modelCarName"] == null ? null : json["modelCarName"],
    modelCarCode: json["modelCarCode"] == null ? null : json["modelCarCode"],
    typeCarName: json["typeCarName"] == null ? null : json["typeCarName"],
    typeCarDescription: json["typeCarDescription"] == null ? null : json["typeCarDescription"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "numberPlaces": numberPlaces == null ? null : numberPlaces,
    "user": user,
    "uid": uid == null ? null : uid,
    "name": name == null ? null : name,
    "code": code == null ? null : code,
    "modelCarName": modelCarName == null ? null : modelCarName,
    "modelCarCode": modelCarCode == null ? null : modelCarCode,
    "typeCarName": typeCarName == null ? null : typeCarName,
    "typeCarDescription": typeCarDescription == null ? null : typeCarDescription,
  };
}

class Driver {
  Driver({
    this.id,
    this.brigadeId,
    this.nummerUser,
    this.user,
  });

  int id;
  int brigadeId;
  int nummerUser;
  User user;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"] == null ? null : json["id"],
    brigadeId: json["brigadeId"] == null ? null : json["brigadeId"],
    nummerUser: json["nummerUser"] == null ? null : json["nummerUser"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "brigadeId": brigadeId == null ? null : brigadeId,
    "nummerUser": nummerUser == null ? null : nummerUser,
    "user": user == null ? null : user.toJson(),
  };
}

class User {
  User({
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
    this.state,
    this.inits,
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
  int state;
  String inits;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    state: json["state"] == null ? null : json["state"],
    inits: json["inits"] == null ? null : json["inits"],
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
    "state": state == null ? null : state,
    "inits": inits == null ? null : inits,
    "email": email == null ? null : email,
  };
}

class FileElement {
  FileElement({
    this.fileId,
    this.file,
    this.id,
  });

  int fileId;
  FileFile file;
  int id;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    fileId: json["fileId"] == null ? null : json["fileId"],
    file: json["file"] == null ? null : FileFile.fromJson(json["file"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "fileId": fileId == null ? null : fileId,
    "file": file == null ? null : file.toJson(),
    "id": id == null ? null : id,
  };
}

class FileFile {
  FileFile({
    this.fullUrl,
  });

  String fullUrl;

  factory FileFile.fromJson(Map<String, dynamic> json) => FileFile(
    fullUrl: json["fullUrl"] == null ? null : json["fullUrl"],
  );

  Map<String, dynamic> toJson() => {
    "fullUrl": fullUrl == null ? null : fullUrl,
  };
}
