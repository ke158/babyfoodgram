import 'package:cloud_firestore/cloud_firestore.dart';

extension AppUserFirestore on FirebaseFirestore {
  CollectionReference<Map<String, dynamic>> usersRef() => collection('users');
  DocumentReference<Map<String, dynamic>> myUsersRef(String uid) =>
      collection('users').doc(uid);

  CollectionReference<Map<String, dynamic>> myPostRef(String uid) =>
      collection('users').doc(uid).collection("myPosts");

  CollectionReference<Map<String, dynamic>> myLikesRef(String uid) =>
      collection('users').doc(uid).collection("myLikesPost");
}
