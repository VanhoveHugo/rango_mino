import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  final cloudUsers = FirebaseFirestore.instance.collection("consumers");

}
