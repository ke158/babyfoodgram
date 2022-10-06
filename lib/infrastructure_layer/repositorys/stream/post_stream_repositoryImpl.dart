import 'package:babyfoodgram/domain_layer/extensions/post_ref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain_layer/domain_providers.dart';
import '../../../domain_layer/interfaces/repository/stream/post_stream_repository.dart';
import '../../../domain_layer/models/post/post.dart';
import '../../../utils/custom_exception.dart';

class PostStreamRepositoryImpl implements PostStreamRepository {
  final Reader _read;
  const PostStreamRepositoryImpl(this._read);

  @override
  Stream<List<Post>> fetchPosts() {
    try {
      final postList = _read(firebaseFirestoreProvider)
          .postsRef()
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        final list = snapshot.docs.map((doc) {
          final jsonObject = Post.fromJson(doc.data());
          return jsonObject;
        }).toList();
        return list;
      });
      return postList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Stream<Post> fetchMyPost(String id) {
    return _read(firebaseFirestoreProvider)
        .userPostsRef(id)
        .snapshots()
        .map((docs) {
      return Post.fromDocument(docs);
    });
  }

  @override
  Stream<Post> fetchMyLike(String id) {
    throw UnimplementedError();
  }
}
