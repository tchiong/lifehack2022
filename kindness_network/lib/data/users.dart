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

  static Future<int> generateUserId() async {
    Map? nextIdData = await Firebase().readData('users/id');
    int nextId;

    if (nextIdData == null) {
      nextId = 0;
    } else {
      List<dynamic> ids =
          nextIdData.values.toList().map((request) => request['id']).toList();
      ids.sort(((a, b) => b - a));
      nextId = ids.first + 1;
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

  static Future<List<User>> getAllUsers() async {
    Map? usersData = await Firebase().readData('user/');
    if (usersData == null) {
      return [];
    } else {
      List<User> users = List<User>.from(usersData.values
          .toList()
          .map((userData) => parseJson(userData))
          .toList());
      return users;
    }
  }

  static Future<User?> getUserFromUserId(int id) async {
    Map? userData = await Firebase().readData('user/');
    if (userData == null) {
      return null;
    } else {
      List<User> users = List<User>.from(userData.values
          .toList()
          .map((userData) => parseJson(userData))
          .where((user) => user.id == id)
          .toList());
      return users.isEmpty ? null : users.first;
    }
  }

  static void setUserIdLang(Lang language, int id) async {
    Map? usersData = await Firebase().readData('user/');
    if (usersData != null) {
      String? key;
      List<String> pointer = List<String>.from(usersData.keys.toList());
      for (String string in pointer) {
        if (parseJson(usersData[string]).id == id) {
          key = string;
        }
      }
      if (key != null) {
        User user = parseJson(usersData[key]);
        user.language = language;
        Firebase().pushData('user/$key', user.toJson());
      }
    }
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
