// ignore_for_file: must_be_immutable
import 'package:babyfoodgram/presentation_layer/presentation_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain_layer/models/user/user.dart';
import '../../../infrastructure_layer/infrastructure_providers.dart';
import '../profile/profile_page.dart';

class PostDetailPage extends HookConsumerWidget {
  String _id;
  AppUser _user;
  PostDetailPage(
    this._id,
    this._user,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _postState = ref.watch(postControllerProvider);
    final _postController = ref.watch(postControllerProvider.notifier);

    useEffect(() {
      _postController.fetchUserPost(_id);
      return null;
    }, [_id]);

    final _currentState = ref.watch(authControllerProvider);
    final _isFavorite = ref.watch(isFavoriteProvider("${_postState.id}")).value;

    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("レシピ"), actions: [
          _currentState!.uid == _user.id
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _postController.deletePost(
                        "${_user.id}", "${_postState.id}");
                    Navigator.pop(context);
                  })
              : Container(),
        ]),
        body: _isFavorite != null
            ? SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.network(
                          "${_postState.postImage}",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        color: Colors.black87,
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfilePage("${_user.id}")));
                                },
                                child: _user.profileImage != null
                                    ? CircleAvatar(
                                        radius: 22,
                                        foregroundImage: NetworkImage(
                                            "${_user.profileImage}"),
                                      )
                                    : Container()),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 90,
                              child: Text(
                                "${_user.userName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "作成日",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  DateFormat('yyyy/MM/dd/HH:mm')
                                      .format(_postState.createdAt!),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${_postState.likeCount}",
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                                icon: Icon(Icons.favorite,
                                    color: _isFavorite
                                        ? Colors.pink
                                        : Colors.white),
                                onPressed: () async {
                                  if (_isFavorite != true) {
                                    // likeID作成
                                    await ref
                                        .watch(likeRepositoryProvider)
                                        .setLike("${_currentState.uid}",
                                            "${_postState.id}");
                                    await _postController.setLike(_postState);
                                  } else {
                                    // likeID削除
                                    await ref
                                        .watch(likeRepositoryProvider)
                                        .deleteLike("${_currentState.uid}",
                                            "${_postState.id}");
                                    await _postController
                                        .deleteLike(_postState);
                                  }
                                }),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'レシピ名',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '${_postState.title}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "作り方・材料",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '${_postState.content}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container());
  }
}
