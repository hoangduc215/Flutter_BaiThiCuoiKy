import 'dart:convert';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String password;
  final DateTime birthDate;
  final String image;
  final String bloodGroup;
  final double height;
  final double weight;
  final String eyeColor;
  final Hair hair;
  final String ip;
  final Address address;
  final String macAddress;
  final String university;
  final Bank bank;
  final Company company;
  final String ein;
  final String ssn;
  final String userAgent;
  final Crypto crypto;
  final String role;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
    required this.ip,
    required this.address,
    required this.macAddress,
    required this.university,
    required this.bank,
    required this.company,
    required this.ein,
    required this.ssn,
    required this.userAgent,
    required this.crypto,
    required this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      maidenName: map['maidenName'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      birthDate: _fixDate(map['birthDate']),
      image: map['image'] as String,
      bloodGroup: map['bloodGroup'] as String,
      height: (map['height'] as num).toDouble(),
      weight: (map['weight'] as num).toDouble(),
      eyeColor: map['eyeColor'] as String,
      hair: Hair.fromMap(map['hair'] as Map<String, dynamic>),
      ip: map['ip'] as String,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      macAddress: map['macAddress'] as String,
      university: map['university'] as String,
      bank: Bank.fromMap(map['bank'] as Map<String, dynamic>),
      company: Company.fromMap(map['company'] as Map<String, dynamic>),
      ein: map['ein'] as String,
      ssn: map['ssn'] as String,
      userAgent: map['userAgent'] as String,
      crypto: Crypto.fromMap(map['crypto'] as Map<String, dynamic>),
      role: map['role'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'maidenName': maidenName,
      'age': age,
      'gender': gender,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'birthDate': birthDate.toIso8601String(),
      'image': image,
      'bloodGroup': bloodGroup,
      'height': height,
      'weight': weight,
      'eyeColor': eyeColor,
      'hair': hair.toMap(),
      'ip': ip,
      'address': address.toMap(),
      'macAddress': macAddress,
      'university': university,
      'bank': bank.toMap(),
      'company': company.toMap(),
      'ein': ein,
      'ssn': ssn,
      'userAgent': userAgent,
      'crypto': crypto.toMap(),
      'role': role,
    };
  }

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}

DateTime _fixDate(String date) {
  final parts = date.split('-');
  final year = parts[0];
  final month = parts[1].padLeft(2, '0');
  final day = parts[2].padLeft(2, '0');
  return DateTime.parse("$year-$month-$day");
}

class Hair {
  final String color;
  final String type;

  Hair({required this.color, required this.type});

  factory Hair.fromMap(Map<String, dynamic> map) {
    return Hair(color: map['color'] as String, type: map['type'] as String);
  }

  Map<String, dynamic> toMap() {
    return {'color': color, 'type': type};
  }
}

class Address {
  final String address;
  final String city;
  final String state;
  final String stateCode;
  final String postalCode;
  final Coordinates coordinates;
  final String country;

  Address({
    required this.address,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.coordinates,
    required this.country,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      stateCode: map['stateCode'] as String,
      postalCode: map['postalCode'] as String,
      coordinates: Coordinates.fromMap(
        map['coordinates'] as Map<String, dynamic>,
      ),
      country: map['country'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'stateCode': stateCode,
      'postalCode': postalCode,
      'coordinates': coordinates.toMap(),
      'country': country,
    };
  }
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({required this.lat, required this.lng});

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'lat': lat, 'lng': lng};
  }
}

class Bank {
  final String cardExpire;
  final String cardNumber;
  final String cardType;
  final String currency;
  final String iban;

  Bank({
    required this.cardExpire,
    required this.cardNumber,
    required this.cardType,
    required this.currency,
    required this.iban,
  });

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      cardExpire: map['cardExpire'] as String,
      cardNumber: map['cardNumber'] as String,
      cardType: map['cardType'] as String,
      currency: map['currency'] as String,
      iban: map['iban'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardExpire': cardExpire,
      'cardNumber': cardNumber,
      'cardType': cardType,
      'currency': currency,
      'iban': iban,
    };
  }
}

class Company {
  final String department;
  final String name;
  final String title;
  final Address address;

  Company({
    required this.department,
    required this.name,
    required this.title,
    required this.address,
  });

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      department: map['department'] as String,
      name: map['name'] as String,
      title: map['title'] as String,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'department': department,
      'name': name,
      'title': title,
      'address': address.toMap(),
    };
  }
}

class Crypto {
  final String coin;
  final String wallet;
  final String network;

  Crypto({required this.coin, required this.wallet, required this.network});

  factory Crypto.fromMap(Map<String, dynamic> map) {
    return Crypto(
      coin: map['coin'] as String,
      wallet: map['wallet'] as String,
      network: map['network'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'coin': coin, 'wallet': wallet, 'network': network};
  }
}
