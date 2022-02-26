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

  History copyWith({
    int id,
    String userId,
    int orderId,
    dynamic order,
    int orderIdHistory,
    OrderById orderInHistory,
    String description,
    DateTime dateAdd,
    DateTime dateUpdate,
  }) =>
      History(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        orderId: orderId ?? this.orderId,
        order: order ?? this.order,
        orderIdHistory: orderIdHistory ?? this.orderIdHistory,
        orderInHistory: orderInHistory ?? this.orderInHistory,
        description: description ?? this.description,
        dateAdd: dateAdd ?? this.dateAdd,
        dateUpdate: dateUpdate ?? this.dateUpdate,
      );

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
    this.address,
    this.longitude,
    this.latitude,
    this.addressMorgue,
    this.phoneContact,
    this.secondPhoneContact,
    this.cause,
    this.addInformation,
    this.dateDeath,
    this.state,
    this.isDelete,
    this.dateAdd,
    this.data,
    this.files,
    this.history,
  });

  int id;
  dynamic user;
  int brigadeId;
  dynamic brigade;
  String secondName;
  String firstName;
  String patronymic;
  bool sex;
  int age;
  dynamic deathId;
  String address;
  double longitude;
  double latitude;
  String addressMorgue;
  String phoneContact;
  String secondPhoneContact;
  String cause;
  String addInformation;
  DateTime dateDeath;
  int state;
  bool isDelete;
  DateTime dateAdd;
  dynamic data;
  List<FileElement> files;
  List<History> history;

  OrderById copyWith({
    int id,
    dynamic user,
    int brigadeId,
    dynamic brigade,
    String secondName,
    String firstName,
    String patronymic,
    bool sex,
    int age,
    dynamic deathId,
    String address,
    double longitude,
    double latitude,
    String addressMorgue,
    String phoneContact,
    String secondPhoneContact,
    String cause,
    String addInformation,
    DateTime dateDeath,
    int state,
    bool isDelete,
    DateTime dateAdd,
    dynamic data,
    List<FileElement> files,
    List<History> history,
  }) =>
      OrderById(
        id: id ?? this.id,
        user: user ?? this.user,
        brigadeId: brigadeId ?? this.brigadeId,
        brigade: brigade ?? this.brigade,
        secondName: secondName ?? this.secondName,
        firstName: firstName ?? this.firstName,
        patronymic: patronymic ?? this.patronymic,
        sex: sex ?? this.sex,
        age: age ?? this.age,
        deathId: deathId ?? this.deathId,
        address: address ?? this.address,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        addressMorgue: addressMorgue ?? this.addressMorgue,
        phoneContact: phoneContact ?? this.phoneContact,
        secondPhoneContact: secondPhoneContact ?? this.secondPhoneContact,
        cause: cause ?? this.cause,
        addInformation: addInformation ?? this.addInformation,
        dateDeath: dateDeath ?? this.dateDeath,
        state: state ?? this.state,
        isDelete: isDelete ?? this.isDelete,
        dateAdd: dateAdd ?? this.dateAdd,
        data: data ?? this.data,
        files: files ?? this.files,
        history: history ?? this.history,
      );

  factory OrderById.fromJson(Map<String, dynamic> json) => OrderById(
    id: json["id"] == null ? null : json["id"],
    user: json["user"],
    brigadeId: json["brigadeId"] == null ? null : json["brigadeId"],
    brigade: json["brigade"],
    secondName: json["secondName"] == null ? null : json["secondName"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    patronymic: json["patronymic"] == null ? null : json["patronymic"],
    sex: json["sex"] == null ? null : json["sex"],
    age: json["age"] == null ? null : json["age"],
    deathId: json["deathId"],
    address: json["address"] == null ? null : json["address"],
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    addressMorgue: json["addressMorgue"] == null ? null : json["addressMorgue"],
    phoneContact: json["phoneContact"] == null ? null : json["phoneContact"],
    secondPhoneContact: json["secondPhoneContact"] == null ? null : json["secondPhoneContact"],
    cause: json["cause"] == null ? null : json["cause"],
    addInformation: json["addInformation"] == null ? null : json["addInformation"],
    dateDeath: json["dateDeath"] == null ? null : DateTime.parse(json["dateDeath"]),
    state: json["state"] == null ? null : json["state"],
    isDelete: json["isDelete"] == null ? null : json["isDelete"],
    dateAdd: json["dateAdd"] == null ? null : DateTime.parse(json["dateAdd"]),
    data: json["data"],
    files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
    history: json["history"] == null ? null : List<History>.from(json["history"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user": user,
    "brigadeId": brigadeId == null ? null : brigadeId,
    "brigade": brigade,
    "secondName": secondName == null ? null : secondName,
    "firstName": firstName == null ? null : firstName,
    "patronymic": patronymic == null ? null : patronymic,
    "sex": sex == null ? null : sex,
    "age": age == null ? null : age,
    "deathId": deathId,
    "address": address == null ? null : address,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "addressMorgue": addressMorgue == null ? null : addressMorgue,
    "phoneContact": phoneContact == null ? null : phoneContact,
    "secondPhoneContact": secondPhoneContact == null ? null : secondPhoneContact,
    "cause": cause == null ? null : cause,
    "addInformation": addInformation == null ? null : addInformation,
    "dateDeath": dateDeath == null ? null : dateDeath.toIso8601String(),
    "state": state == null ? null : state,
    "isDelete": isDelete == null ? null : isDelete,
    "dateAdd": dateAdd == null ? null : dateAdd.toIso8601String(),
    "data": data,
    "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toJson())),
    "history": history == null ? null : List<dynamic>.from(history.map((x) => x.toJson())),
  };
}

class FileElement {
  FileElement({
    this.id,
    this.fileId,
    this.file,
    this.orderId,
    this.dateAdd,
  });

  int id;
  int fileId;
  dynamic file;
  int orderId;
  DateTime dateAdd;

  FileElement copyWith({
    int id,
    int fileId,
    dynamic file,
    int orderId,
    DateTime dateAdd,
  }) =>
      FileElement(
        id: id ?? this.id,
        fileId: fileId ?? this.fileId,
        file: file ?? this.file,
        orderId: orderId ?? this.orderId,
        dateAdd: dateAdd ?? this.dateAdd,
      );

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    id: json["id"] == null ? null : json["id"],
    fileId: json["fileId"] == null ? null : json["fileId"],
    file: json["file"],
    orderId: json["orderId"] == null ? null : json["orderId"],
    dateAdd: json["dateAdd"] == null ? null : DateTime.parse(json["dateAdd"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fileId": fileId == null ? null : fileId,
    "file": file,
    "orderId": orderId == null ? null : orderId,
    "dateAdd": dateAdd == null ? null : dateAdd.toIso8601String(),
  };
}
