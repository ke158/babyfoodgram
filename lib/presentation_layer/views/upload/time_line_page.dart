// ignore_for_file: dead_code

import 'package:babyfoodgram/presentation_layer/presentation_providers.dart';
import 'package:babyfoodgram/presentation_layer/views/profile/profile_page.dart';
import 'package:babyfoodgram/presentation_layer/views/settings/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../infrastructure_layer/infrastructure_providers.dart';
import '../screen.dart';
import 'post_ detail_page.dart';

class TimeLinePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ////ログイン時にstateが違う
    final _userState = ref.watch(userControllerProvider);
    ////

    final _currentState = ref.watch(authControllerProvider);
    final _postController = ref.watch(postControllerProvider.notifier);
    final _authController = ref.watch(authControllerProvider.notifier);
    final _postsStream = ref.watch(postsStreamProvider);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("タイムライン"),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                onPressed: () {
                  //
                  //検索機能追加予定
                  //
                })
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ////////////
              UserAccountsDrawerHeader(
                currentAccountPicture: ClipOval(
                    child: CircleAvatar(
                  radius: 22,
                  foregroundImage: NetworkImage("${_userState.profileImage}"),
                )),
                accountName: Text("${_userState.userName}"),
                accountEmail: Text("@${_userState.userId}"),
              ),
              ////////////

              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: GestureDetector(
                    onTap: () {
                      while (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Screen()));
                    },
                    child: Text(
                      "ホーム",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                ),
                title: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(_currentState!.uid)));
                    },
                    child: Text(
                      "マイページ",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                ),
                title: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingPage()));
                    },
                    child: Text(
                      "設定",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                ),
                title: GestureDetector(
                    onTap: () async {
                      while (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      await _authController.signOut();
                    },
                    child: Text(
                      "ログアウト",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ],
          ),
        ),
        body: _postsStream.when(data: (_postData) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(10.0),
              itemCount: _postData.length,
              itemBuilder: (context, index) {
                final _post = _postData[index];
                final userData =
                    ref.watch(userStreamProvider("${_post.postUserId}")).value;
                if (userData != null) {
                  final _isFavoriteData =
                      ref.watch(isFavoriteProvider("${_post.id}")).value;
                  if (_isFavoriteData != null) {
                    final isFavorite = _isFavoriteData;
                    return ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(20),
                      child: GridTile(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostDetailPage(
                                        "${_post.id}", userData)));
                          },
                          child: Image.network(
                            "${_post.postImage}",
                            fit: BoxFit.contain,
                          ),
                        ),
                        header: GridTileBar(
                          backgroundColor: Colors.black87,
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePage("${userData.id}")));
                            },
                            child: CircleAvatar(
                              radius: 16,
                              foregroundImage:
                                  NetworkImage("${userData.profileImage}"),
                            ),
                          ),
                          title: Column(
                            children: [
                              Text(
                                "${userData.userName}",
                              ),
                              Text(
                                "@${userData.userId}",
                              ),
                            ],
                          ),
                        ),
                        footer: GridTileBar(
                          backgroundColor: Colors.black87,
                          title: Text(
                            "${_post.title}",
                            textAlign: TextAlign.center,
                          ),
                          trailing: Row(
                            children: [
                              Text(
                                "${_post.likeCount}",
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                  icon: Icon(Icons.favorite,
                                      color: isFavorite
                                          ? Colors.pink
                                          : Colors.white),
                                  onPressed: () async {
                                    if (isFavorite != true) {
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
              child: Text('エラー'),
            ),
          );
          // },
        }, loading: () {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }));
  }
}
