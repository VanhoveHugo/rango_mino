import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rango_mino/src/models/utilisateur.dart';

class FirestoreHelper {
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("UTILISATEURS");
  final cloudMessage = FirebaseFirestore.instance.collection("MESSAGES");

  Future<Utilisateur> inscription(String email, String password, String nom, String prenom) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = credential.user;
    if (user == null) {
      return Future.error("error");
    } else {
      String uid = user.uid;
      Map<String, dynamic> map = {
        "NOM": nom,
        "PRENOM": prenom,
        "EMAIL": email,
        "FAVORIS": []
      };
      addUser(uid, map);
      return getUser(uid);
    }
  }

  Future<Utilisateur> getUser(String id) async {
    DocumentSnapshot snapshots = await cloudUsers.doc(id).get();
    return Utilisateur(snapshots);
  }

  Future<Utilisateur> Connect(String email, String password) async {
    UserCredential credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    User? user = credential.user;
    if (user == null) {
      return Future.error("erreur");
    } else {
      String uid = user.uid;
      return getUser(uid);
    }
  }

  addUser(String id, Map<String, dynamic> map) {
    cloudUsers.doc(id).set(map);
  }

  updateUser(String id, Map<String, dynamic> data) {
    cloudUsers.doc(id).update(data);
  }

  Future<String> stockageImage(
      {required String dossier,
      required String dossierPersonnel,
      required String nameImage,
      required Uint8List bytesImage}) async {
    String url = "";
    TaskSnapshot taskSnapshot = await storage
        .ref("$dossier/$dossierPersonnel/$nameImage")
        .putData(bytesImage);
    url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
