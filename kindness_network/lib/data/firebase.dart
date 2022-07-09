import 'package:firebase_database/firebase_database.dart';

class Firebase {
  FirebaseDatabase database = FirebaseDatabase.instance;

  Firebase();

  void pushData(String path, Map data) async {
    DatabaseReference ref = database.ref();
    await ref.set(data);
  }

  Future<Object?> readData(String path) async {
    final DatabaseReference ref = database.ref();
    final DataSnapshot snapshot = await ref.child(path).get();
    return snapshot.value;
  }
}
