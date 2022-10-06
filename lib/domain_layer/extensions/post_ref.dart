import 'package:cloud_firestore/cloud_firestore.dart';

extension PostFirestore on FirebaseFirestore {
  CollectionReference<Map<String, dynamic>> postsRef() => collection('posts');
  DocumentReference<Map<String, dynamic>> userPostsRef(String id) =>
      collection('posts').doc(id);
}
