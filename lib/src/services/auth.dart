import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rango_mino/src/models/consumers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {

  static Future<bool> isEmailUsed(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("consumers")
        .where("email", isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  static Future<Consumer> login(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      if (user == null) return Consumer.empty();
      String uid = user.uid;
      return Consumer.readConsumer(uid);
    } catch (error) {
      return Consumer.empty();
    }
  }

  static Future<Consumer> register(
      String email, String password, String firstname, String username) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = credential.user;
    if (user == null) return Future.error("error");
    String uid = user.uid;
    Map<String, dynamic> map = {
      "createdAt": DateTime.now().toString(),
      "updatedAt": DateTime.now().toString(),
      "lastLogin": DateTime.now().toString(),
      "email": email,
      "firstname": firstname,
      "username": username,
    };
    Consumer.createConsumer(uid, map);
    return Consumer.readConsumer(uid);
  }
}