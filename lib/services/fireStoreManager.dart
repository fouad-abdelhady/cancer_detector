import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreManager {
  static final FireStoreManager _fireStoreManager =
      FireStoreManager._internal();
  final firestoreInstance = FirebaseFirestore.instance;
  factory FireStoreManager() => _fireStoreManager;
  FireStoreManager._internal() {}

  Future<String> getUserName(String email) async {
    final querySnapshot = await firestoreInstance
        .collection('users')
        .where('Email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final userDoc = querySnapshot.docs.first;
      final userName = userDoc.get('Name');
      return userName;
    } else {
      return "";
    }
  }
}
