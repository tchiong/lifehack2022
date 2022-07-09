import 'package:firebase_database/firebase_database.dart';

class Firebase {
  FirebaseDatabase database = FirebaseDatabase.instance;

  Firebase();

  void pushDataToList(String path, dynamic data) async {
    DatabaseReference ref = database.ref(path);
    DatabaseReference listPush = ref.push();
    await listPush.set(data);
  }

  void pushData(String path, dynamic data) async {
    DatabaseReference ref = database.ref(path);
    await ref.set(data);
  }

  Future<dynamic> readData(String path) async {
    final DatabaseReference ref = database.ref();
    final DataSnapshot snapshot = await ref.child(path).get();
    return snapshot.value;
  }

  void deleteData(String path) async {
    final DatabaseReference ref = database.ref();
    ref.child(path).remove();
  }
}
