class AppUser {
  String? uid;
  String? firstName;
  String? lastName;
  Phone? phone;
  String? address;
  String? email;
  DocumentType? documentType;
  Documents? photo;

  AppUser({
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.email,
    this.documentType,
    this.photo,
    this.uid,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'] != null ? Phone.fromJson(json['phone']) : null;
    address = json['address'];
    email = json['email'];
    documentType = json['documentType'] != null
        ? DocumentType.fromJson(json['documentType'])
        : null;
    photo = json['photo'] != null ? Documents.fromJson(json['photo']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    if (phone != null) {
      data['phone'] = phone!.toJson();
    }
    data['address'] = address;
    data['email'] = email;

    if (documentType != null) {
      data['documentType'] = documentType!.toJson();
    }
    if (photo != null) {
      data['photo'] = photo!.toJson();
    }
    return data;
  }
}

class Phone {
  String? countryCode;
  String? number;

  Phone({this.countryCode, this.number});

  Phone.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['countryCode'] = countryCode;
    data['number'] = number;
    return data;
  }
}

class DocumentType {
  String? type;
  List<Documents>? documents;

  DocumentType({this.type, this.documents});

  DocumentType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['documents'] != null) {
      documents = <Documents>[];
      json['documents'].forEach((v) {
        documents!.add(Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    if (documents != null) {
      data['documents'] = documents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  String? fileName;
  String? fileType;
  String? file;

  Documents({this.fileName, this.fileType, this.file});

  Documents.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    fileType = json['fileType'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fileName'] = fileName;
    data['fileType'] = fileType;
    data['file'] = file;
    return data;
  }
}
