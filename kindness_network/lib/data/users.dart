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
}

enum UserType { volunteer, beneficiary }

enum Lang { en, ch, ms, ta }
