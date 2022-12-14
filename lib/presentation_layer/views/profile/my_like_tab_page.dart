import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../infrastructure_layer/infrastructure_providers.dart';
import '../../presentation_providers.dart';
import '../upload/post_ detail_page.dart';
import 'profile_page.dart';

class MyLikeTabPage extends StatefulHookConsumerWidget {
  final String uid;

  const MyLikeTabPage({Key? key, required this.uid}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyLikeTabPageState();
}

class _MyLikeTabPageState extends ConsumerState<MyLikeTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _myLikeIds = ref.watch(mylikeIdsStreamProvider(widget.uid));
    final _postController = ref.watch(postControllerProvider.notifier);
    final _currentState = ref.watch(authControllerProvider);
    return _myLikeIds.when(data: (myLikeIdsData) {
      return ListView.builder(
          itemCount: myLikeIdsData.length,
          itemBuilder: (context, index) {
            final _likeId = myLikeIdsData[index];
            final _post = ref.watch(myPostStreamProvider(_likeId)).value;
            if (_post != null) {
              final _user =
                  ref.watch(userStreamProvider("${_post.postUserId}")).value;
              final _isFavorite =
                  ref.watch(isFavoriteProvider("${_post.id}")).value;
              if (_user != null && _isFavorite != null) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PostDetailPage("${_post.id}", _user)));
                  },
                  child: Container(
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
                                          image: NetworkImage(
                                              "${_post.postImage}")),
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
                                    "?????????",
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
                                      // likeID??????
                                      await ref
                                          .watch(likeRepositoryProvider)
                                          .setLike("${_currentState!.uid}",
                                              "${_post.id}");
                                      await _postController.setLike(_post);
                                    } else {
                                      // likeID??????
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
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          });
    }, error: (_, __) {
      return const Scaffold(
        body: Center(
          child: Text('?????????'),
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
