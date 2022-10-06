import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../infrastructure_layer/infrastructure_providers.dart';
import '../../presentation_providers.dart';
import 'profile_page.dart';

class MyPostTabPage extends StatefulHookConsumerWidget {
  final String uid;

  const MyPostTabPage({Key? key, required this.uid}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyPostTabPageState();
}

class _MyPostTabPageState extends ConsumerState<MyPostTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _userState = ref.watch(userControllerProvider);
    final _myPostIds = ref.watch(myPostIdsStreamProvider(widget.uid));
    final _postController = ref.watch(postControllerProvider.notifier);
    final _currentState = ref.watch(authControllerProvider);
    //投稿内容 view
    return _myPostIds.when(data: (myPostIdsData) {
      return ListView.builder(
          itemCount: myPostIdsData.length,
          itemBuilder: ((context, index) {
            final _postId = myPostIdsData[index];
            final _post = ref.watch(myPostStreamProvider(_postId)).value;
            if (_post != null) {
              final _isFavorite =
                  ref.watch(isFavoriteProvider("${_post.id}")).value;
              if (_isFavorite != null) {
                return Container(
                  width: double.infinity,
                  height: 170,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          _post.postImage != ""
                              ? Container(
                                  width: 80,
                                  height: 80,
                                  child: ClipRect(
                                      child: FittedBox(
                                    child: Image(
                                        image:
                                            NetworkImage("${_post.postImage}")),
                                    fit: BoxFit.cover,
                                  )),
                                )
                              : Container(
                                  width: 80,
                                  height: 80,
                                ),
                          Expanded(
                              child: Container(
                                  height: 80,
                                  child:
                                      Center(child: Text("${_post.title}")))),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 70,
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
                                              ProfilePage("${_userState.id}")));
                                },
                                child: _userState.profileImage != null
                                    ? CircleAvatar(
                                        radius: 22,
                                        foregroundImage: NetworkImage(
                                            "${_userState.profileImage}"),
                                      )
                                    : Container()),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              child: Text(
                                "${_userState.userName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
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
                                      .format(_post.createdAt!),
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
                              "${_post.likeCount}",
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
                                        .setLike("${_currentState!.uid}",
                                            "${_post.id}");
                                    await _postController.setLike(_post);
                                  } else {
                                    // likeID削除
                                    await ref
                                        .watch(likeRepositoryProvider)
                                        .deleteLike("${_currentState!.uid}",
                                            "${_post.id}");
                                    await _postController.deleteLike(_post);
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          }));
    }, error: (_, __) {
      return const Scaffold(
        body: Center(
          child: Text('エラー'),
        ),
      );
    }, loading: () {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
