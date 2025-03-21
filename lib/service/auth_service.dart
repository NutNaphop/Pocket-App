import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkUser(String uid) async {
  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .get(const GetOptions(source: Source.server));

  return documentSnapshot.exists ; 
}
