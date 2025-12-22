class AppUser {
  String? firstName;
  String? lastName;
  Phone? phone;
  String? address;
  String? email;
  String? password;
  DocumentType? documentType;
  Documents? photo;

  AppUser({
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.email,
    this.password,
    this.documentType,
    this.photo,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'] != null ? new Phone.fromJson(json['phone']) : null;
    address = json['address'];
    email = json['email'];
    password = json['password'];
    documentType = json['documentType'] != null
        ? new DocumentType.fromJson(json['documentType'])
        : null;
    photo = json['photo'] != null
        ? new Documents.fromJson(json['photo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    if (this.phone != null) {
      data['phone'] = this.phone!.toJson();
    }
    data['address'] = this.address;
    data['email'] = this.email;
    
    if (this.documentType != null) {
      data['documentType'] = this.documentType!.toJson();
    }
    if (this.photo != null) {
      data['photo'] = this.photo!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryCode'] = this.countryCode;
    data['number'] = this.number;
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
        documents!.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.documents != null) {
      data['documents'] = this.documents!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['fileType'] = this.fileType;
    data['file'] = this.file;
    return data;
  }
}
