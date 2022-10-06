// ignore_for_file: must_be_immutable
import 'package:babyfoodgram/presentation_layer/presentation_providers.dart';
import 'package:babyfoodgram/presentation_layer/views/profile/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screen.dart';
import '../settings/setting_page.dart';
import 'my_like_tab_page.dart';
import 'my_post_tab_page.dart';

class ProfilePage extends HookConsumerWidget {
  String _uid;
  ProfilePage(this._uid);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userState = ref.watch(userControllerProvider);
    final _userController = ref.watch(userControllerProvider.notifier);

    useEffect(() {
      _userController.fetchAppUser("${_uid}");
      return null;
    }, [_uid]);

    final _currentState = ref.watch(authControllerProvider);
    final _authController = ref.watch(authControllerProvider.notifier);
    final _imageController = ref.watch(imageStateControllerProvider.notifier);

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("プロフィール"),
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: ClipOval(
                    child: CircleAvatar(
                  radius: 22,
                  foregroundImage: NetworkImage("${_userState.profileImage}"),
                )),
                accountName: Text("${_userState.userName}"),
                accountEmail: Text("@${_userState.userId}"),
              ),
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
              _userState.id != _currentState!.uid
                  ? ListTile(
                      leading: Icon(
                        Icons.person,
                      ),
                      title: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfilePage(_currentState.uid)));
                          },
                          child: Text(
                            "マイページ",
                            style: TextStyle(fontSize: 20),
                          )),
                    )
                  : ListTile(
                      leading: Icon(
                        Icons.edit,
                      ),
                      title: GestureDetector(
                          onTap: () async {
                            await _imageController.clearImage();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfilePage()));
                          },
                          child: Text(
                            "編集",
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
        body: Column(children: [
          Container(
              color: Colors.black87,
              height: 80,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          children: [
                            _userState.profileImage != ""
                                ? CircleAvatar(
                                    radius: 22,
                                    foregroundImage: NetworkImage(
                                        "${_userState.profileImage}"),
                                  )
                                : Container(),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${_userState.userName}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("@${_userState.userId}",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ],
                        ))
                  ])),
          Container(
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.only(right: 10, left: 10),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              )),
              child: Text(_userState.selfIntroduction,
                  style: TextStyle(
                    fontSize: 18,
                  ))),

          // TabBar
          TabBar(tabs: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "投稿",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 50,
                ),
                Tab(
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "いいね",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 50,
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ]),
          Expanded(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                //投稿内容 view
                MyPostTabPage(uid: _uid),
                //いいね view
                MyLikeTabPage(uid: _uid)
              ]))
        ]),
      ),
    );
  }
}
