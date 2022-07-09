import 'package:firebase_database/firebase_database.dart';

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
