import 'package:kindness_network/data/firebase.dart';

class User {
  int id;
  UserType type;
  String name;
  int age;
  String address;
  String specialNeeds;
  String phoneNumber;
  Lang language;

  User({
    required this.id,
    required this.type,
    required this.name,
    required this.age,
    required this.address,
    required this.specialNeeds,
    required this.phoneNumber,
    required this.language,
  });

  Map toJson() {
    return {
      'id': id,
      'type': type.value,
      'name': name,
      'age': age,
      'address': address,
      'specialNeeds': specialNeeds,
      'phoneNumber': phoneNumber,
      'language': language.value
    };
  }

  Future<int> generateUserId() async {
    var nextId = await Firebase().readData('users/id');

    if (nextId.exists) {
      Firebase().pushData('users/id', nextId + 1);
    } else {
      nextId = 0;
      Firebase().pushData('users/id', 1);
    }
    return nextId;
  }

  static parseJson(record) {
    Map<String, dynamic> attributes = {
      'id': '',
      'type': '',
      'name': '',
      'age': '',
      'address': '',
      'specialNeeds': '',
      'phoneNumber': '',
      'language': '',
    };

    record.forEach((key, value) => {attributes[key] = value});

    UserType type = UserType.volunteer;
    Lang language = Lang.en;
    switch (attributes['type']) {
      case 'volunteer':
        {
          type = UserType.volunteer;
        }
        break;
      case 'beneficiary':
        {
          type = UserType.beneficiary;
        }
        break;
    }
    switch (attributes['language']) {
      case 'en':
        {
          language = Lang.en;
        }
        break;
      case 'ch':
        {
          language = Lang.ch;
        }
        break;
      case 'ms':
        {
          language = Lang.ms;
        }
        break;
      case 'ta':
        {
          language = Lang.ta;
        }
        break;
    }

    return User(
        id: attributes['id'],
        type: type,
        name: attributes['name'],
        age: attributes['age'],
        address: attributes['address'],
        specialNeeds: attributes['specialNeeds'],
        phoneNumber: attributes['phoneNumber'],
        language: language);
  }
}

enum UserType {
  volunteer('volunteer'),
  beneficiary('beneficiary');

  const UserType(this.value);
  final String value;
}

enum Lang {
  en('en'),
  ch('ch'),
  ms('ms'),
  ta('ta');

  const Lang(this.value);
  final String value;
}
