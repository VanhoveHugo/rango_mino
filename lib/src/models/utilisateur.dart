import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  late String id;
  late String lastname;
  late String name;
  String? avatar;
  DateTime? birthday;
  String? nickname;
  late String email;
  List? favoris;

  String get fullName {
    return "$lastname $name";
  }

  Utilisateur(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    lastname = map['NOM'];
    name = map['PRENOM'];
    email = map['EMAIL'];
    avatar = map["AVATAR"] ??
        "https://cdn1.iconfinder.com/data/icons/user-pictures/100/unknown-1024.png";
    favoris = map["FAVORIS"] ?? [];
    Timestamp? timeprovisoire = map["BIRTHDAY"];
    if (timeprovisoire == null) {
      birthday = DateTime.now();
    } else {
      birthday = timeprovisoire.toDate();
    }
  }

  Utilisateur.empty() {
    id = "";
    lastname = "";
    name = "";
    email = "";
  }
}
