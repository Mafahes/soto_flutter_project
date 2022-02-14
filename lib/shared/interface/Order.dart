// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);
// @dart=2.9

import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    this.id,
    this.brigadeId,
    this.source,
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
    this.dateDeath,
    this.state,
    this.isDelete,
    this.dateAdd,
    this.files,
  });

  int id;
  int brigadeId;
  String source;
  String secondName;
  String firstName;
  String patronymic;
  bool sex;
  int age;
  String deathId;
  String address;
  double longitude;
  double latitude;
  String addressMorgue;
  String phoneContact;
  String secondPhoneContact;
  String cause;
  DateTime dateDeath;
  int state;
  bool isDelete;
  DateTime dateAdd;
  List<FileElement> files;

  Order copyWith({
    int id,
    int brigadeId,
    String source,
    String secondName,
    String firstName,
    String patronymic,
    bool sex,
    int age,
    String deathId,
    String address,
    double longitude,
    double latitude,
    String addressMorgue,
    String phoneContact,
    String secondPhoneContact,
    String cause,
    DateTime dateDeath,
    int state,
    bool isDelete,
    DateTime dateAdd,
    List<FileElement> files,
  }) =>
      Order(
        id: id ?? this.id,
        brigadeId: brigadeId ?? this.brigadeId,
        source: source ?? this.source,
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
        dateDeath: dateDeath ?? this.dateDeath,
        state: state ?? this.state,
        isDelete: isDelete ?? this.isDelete,
        dateAdd: dateAdd ?? this.dateAdd,
        files: files ?? this.files,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] == null ? null : json["id"],
    brigadeId: json["brigadeId"] == null ? null : json["brigadeId"],
    source: json["source"] == null ? null : json["source"],
    secondName: json["secondName"] == null ? null : json["secondName"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    patronymic: json["patronymic"] == null ? null : json["patronymic"],
    sex: json["sex"] == null ? null : json["sex"],
    age: json["age"] == null ? null : json["age"],
    deathId: json["deathId"] == null ? null : json["deathId"],
    address: json["address"] == null ? null : json["address"],
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    addressMorgue: json["addressMorgue"] == null ? null : json["addressMorgue"],
    phoneContact: json["phoneContact"] == null ? null : json["phoneContact"],
    secondPhoneContact: json["secondPhoneContact"] == null ? null : json["secondPhoneContact"],
    cause: json["cause"] == null ? null : json["cause"],
    dateDeath: json["dateDeath"] == null ? null : DateTime.parse(json["dateDeath"]),
    state: json["state"] == null ? null : json["state"],
    isDelete: json["isDelete"] == null ? null : json["isDelete"],
    dateAdd: json["dateAdd"] == null ? null : DateTime.parse(json["dateAdd"]),
    files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "brigadeId": brigadeId == null ? null : brigadeId,
    "source": source == null ? null : source,
    "secondName": secondName == null ? null : secondName,
    "firstName": firstName == null ? null : firstName,
    "patronymic": patronymic == null ? null : patronymic,
    "sex": sex == null ? null : sex,
    "age": age == null ? null : age,
    "deathId": deathId == null ? null : deathId,
    "address": address == null ? null : address,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "addressMorgue": addressMorgue == null ? null : addressMorgue,
    "phoneContact": phoneContact == null ? null : phoneContact,
    "secondPhoneContact": secondPhoneContact == null ? null : secondPhoneContact,
    "cause": cause == null ? null : cause,
    "dateDeath": dateDeath == null ? null : dateDeath.toIso8601String(),
    "state": state == null ? null : state,
    "isDelete": isDelete == null ? null : isDelete,
    "dateAdd": dateAdd == null ? null : dateAdd.toIso8601String(),
    "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toJson())),
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
  FileFile file;
  int orderId;
  DateTime dateAdd;

  FileElement copyWith({
    int id,
    int fileId,
    FileFile file,
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
    file: json["file"] == null ? null : FileFile.fromJson(json["file"]),
    orderId: json["orderId"] == null ? null : json["orderId"],
    dateAdd: json["dateAdd"] == null ? null : DateTime.parse(json["dateAdd"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fileId": fileId == null ? null : fileId,
    "file": file == null ? null : file.toJson(),
    "orderId": orderId == null ? null : orderId,
    "dateAdd": dateAdd == null ? null : dateAdd.toIso8601String(),
  };
}

class FileFile {
  FileFile({
    this.id,
    this.fileName,
    this.fileSize,
    this.fileType,
    this.fullUrl,
  });

  int id;
  String fileName;
  int fileSize;
  int fileType;
  String fullUrl;

  FileFile copyWith({
    int id,
    String fileName,
    int fileSize,
    int fileType,
    String fullUrl,
  }) =>
      FileFile(
        id: id ?? this.id,
        fileName: fileName ?? this.fileName,
        fileSize: fileSize ?? this.fileSize,
        fileType: fileType ?? this.fileType,
        fullUrl: fullUrl ?? this.fullUrl,
      );

  factory FileFile.fromJson(Map<String, dynamic> json) => FileFile(
    id: json["id"] == null ? null : json["id"],
    fileName: json["fileName"] == null ? null : json["fileName"],
    fileSize: json["fileSize"] == null ? null : json["fileSize"],
    fileType: json["fileType"] == null ? null : json["fileType"],
    fullUrl: json["fullUrl"] == null ? null : json["fullUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fileName": fileName == null ? null : fileName,
    "fileSize": fileSize == null ? null : fileSize,
    "fileType": fileType == null ? null : fileType,
    "fullUrl": fullUrl == null ? null : fullUrl,
  };
}
