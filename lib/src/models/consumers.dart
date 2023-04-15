import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rango_mino/core/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Consumer {
  late String id;
  late String createdAt;
  late String updatedAt;
  late String lastLogin;
  late String email;
  late String firstname;
  late String username;
  String? city;
  String? job;
  String? picture;

  Consumer(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
    lastLogin = map['lastLogin'];
    email = map['email'];
    firstname = map['firstname'];
    username = map['username'];
    if (map['city'] != null) city = map['city'];
    if (map['job'] != null) job = map['job'];
    picture = map['picture'] ?? AppData.defaultImage;
  }

  Consumer.empty() {
    id = "";
    createdAt = "";
    updatedAt = "";
    lastLogin = "";
    email = "";
    firstname = "";
    username = "";
    city = "";
    job = "";
    picture = AppData.defaultImage;
  }

  static Future<Consumer> login(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = credential.user;
    if (user == null) return Future.error("erreur");
    String uid = user.uid;
    return readConsumer(uid);
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
    createConsumer(uid, map);
    return readConsumer(uid);
  }

  static createConsumer(String id, Map<String, dynamic> map) {
    FirebaseFirestore.instance.collection("consumers").doc(id).set(map);
  }

  static Future<Consumer> readConsumer(String id) async {
    DocumentSnapshot snapshots =
        await FirebaseFirestore.instance.collection("consumers").doc(id).get();
    return Consumer(snapshots);
  }

  static updateConsumer(String id, Map<String, dynamic> data) {
    FirebaseFirestore.instance.collection("consumers").doc(id).update(data);
  }

  static deleteConsumer(String id) {
    FirebaseFirestore.instance.collection("consumers").doc(id).delete();
  }

  static Future<String> uploadPicture(
      {required String dossier,
      required String dossierPersonnel,
      required String nameImage,
      required Uint8List bytesImage}) async {
    String url = "";
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref("$dossier/$dossierPersonnel/$nameImage")
        .putData(bytesImage);
    url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
