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
  final DateTime? birthDate;
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
    this.birthDate,
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      firstName: json['firstName'] as String? ?? 'Hoàng',
      lastName: json['lastName'] as String? ?? 'Đức',
      maidenName: json['maidenName'] as String? ?? 'Đức Cận',
      age: json['age'] as int? ?? 22,
      gender: json['gender'] as String? ?? 'male',
      email: json['email'] as String? ?? 'hoangminhduc21052003@gmail.com',
      phone: json['phone'] as String? ?? '+84 329 801 850',
      username: json['username'] as String? ?? 'hoangduc2003',
      password: json['password'] as String? ?? '123456',
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,
      image:
          json['image'] as String? ??
          'https://images.unsplash.com/photo-1728577740843-5f29c7586afe?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      bloodGroup: json['bloodGroup'] as String? ?? 'A',
      height: (json['height'] as num?)?.toDouble() ?? 176.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 65.0,
      eyeColor: json['eyeColor'] as String? ?? 'Brown',
      hair: json['hair'] != null
          ? Hair.fromJson(json['hair'])
          : Hair(color: 'Black', type: 'Straight'),
      ip: json['ip'] as String? ?? '198.233.334',
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : Address(
              address: '137 Phan Đình Phùng',
              city: 'Huế',
              state: 'Thừa Thiên Huế',
              stateCode: '29112',
              postalCode: '29112',
              coordinates: Coordinates(lat: 0.0, lng: 0.0),
              country: 'Việt Nam',
            ),
      macAddress: json['macAddress'] as String? ?? '',
      university: json['university'] as String? ?? 'DHKH Huế',
      bank: json['bank'] != null
          ? Bank.fromJson(json['bank'])
          : Bank(
              cardExpire: '',
              cardNumber: '',
              cardType: '',
              currency: '',
              iban: '',
            ),
      company: json['company'] != null
          ? Company.fromJson(json['company'])
          : Company(
              department: '',
              name: '',
              title: '',
              address: Address(
                address: '',
                city: '',
                state: '',
                stateCode: '',
                postalCode: '',
                coordinates: Coordinates(lat: 0.0, lng: 0.0),
                country: '',
              ),
            ),
      ein: json['ein'] as String? ?? '',
      ssn: json['ssn'] as String? ?? '',
      userAgent: json['userAgent'] as String? ?? '',
      crypto: json['crypto'] != null
          ? Crypto.fromJson(json['crypto'])
          : Crypto(coin: '', wallet: '', network: ''),
      role: json['role'] as String? ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
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
      'birthDate': birthDate?.toIso8601String(),
      'image': image,
      'bloodGroup': bloodGroup,
      'height': height,
      'weight': weight,
      'eyeColor': eyeColor,
      'hair': hair.toJson(),
      'ip': ip,
      'address': address.toJson(),
      'macAddress': macAddress,
      'university': university,
      'bank': bank.toJson(),
      'company': company.toJson(),
      'ein': ein,
      'ssn': ssn,
      'userAgent': userAgent,
      'crypto': crypto.toJson(),
      'role': role,
    };
  }
}

// Nested models with default values
class Hair {
  final String color;
  final String type;

  Hair({required this.color, required this.type});

  factory Hair.fromJson(Map<String, dynamic> json) {
    return Hair(
      color: json['color'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'color': color, 'type': type};
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({required this.lat, required this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
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

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      stateCode: json['stateCode'] as String? ?? '',
      postalCode: json['postalCode'] as String? ?? '',
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : Coordinates(lat: 0.0, lng: 0.0),
      country: json['country'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'city': city,
    'state': state,
    'stateCode': stateCode,
    'postalCode': postalCode,
    'coordinates': coordinates.toJson(),
    'country': country,
  };
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

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      cardExpire: json['cardExpire'] as String? ?? '',
      cardNumber: json['cardNumber'] as String? ?? '',
      cardType: json['cardType'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      iban: json['iban'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'cardExpire': cardExpire,
    'cardNumber': cardNumber,
    'cardType': cardType,
    'currency': currency,
    'iban': iban,
  };
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

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      department: json['department'] as String? ?? '',
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : Address(
              address: '',
              city: '',
              state: '',
              stateCode: '',
              postalCode: '',
              coordinates: Coordinates(lat: 0.0, lng: 0.0),
              country: '',
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    'department': department,
    'name': name,
    'title': title,
    'address': address.toJson(),
  };
}

class Crypto {
  final String coin;
  final String wallet;
  final String network;

  Crypto({required this.coin, required this.wallet, required this.network});

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      coin: json['coin'] as String? ?? '',
      wallet: json['wallet'] as String? ?? '',
      network: json['network'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'coin': coin,
    'wallet': wallet,
    'network': network,
  };
}
