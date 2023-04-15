import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rango_mino/core/data.dart';

class Consumer {
  late String id;
  late String createdAt;
  late String updatedAt;
  late String lastLogin;
  late String email;
  late String firstname;
  late String username;
  late String? city;
  late String? job;
  late String? picture;

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
}
