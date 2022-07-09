import 'package:firebase_database/firebase_database.dart';

class Firebase {
  FirebaseDatabase database = FirebaseDatabase.instance;

  Firebase();

  void pushData(String path, dynamic data) async {
    DatabaseReference ref = database.ref(path);
    DatabaseReference listPush = ref.push();
    await listPush.set(data);
  }

  // Firebase().pushData('users/', {
  //  'id': 0,
  //  'type': UserType.beneficiary.value,
  //  'name': 'Uncle',
  //  'age': 60,
  //  'address': 'Singapore',
  //  'specialNeeds': 'Autism',
  //  'phoneNumber': '10001000',
  //  'language': Lang.ms.value
  // });

  Future<dynamic> readData(String path) async {
    final DatabaseReference ref = database.ref();
    final DataSnapshot snapshot = await ref.child(path).get();
    return snapshot.value;
  }

  // final values = await Firebase().readData('users/');
  // User.parseJson(values?[0]);
}
