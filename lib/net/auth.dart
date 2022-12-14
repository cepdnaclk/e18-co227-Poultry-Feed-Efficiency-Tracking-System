import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final storage = new FlutterSecureStorage();

  Future<void> storetokenanddata(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.user!.uid.toString());
    //var val = userCredential.credential?.token;

    //print("shamod : " + val.toString());
    //await storage.write(
    //key: "userCredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await storage.delete(key: "token");
    } catch (e) {}
  }
}
