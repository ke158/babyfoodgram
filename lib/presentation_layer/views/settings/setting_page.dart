import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screen.dart';
import '../../presentation_providers.dart';

class SettingPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authController = ref.watch(authControllerProvider.notifier);
    final _authState = ref.watch(authControllerProvider);

    final _postController = ref.watch(postControllerProvider.notifier);
    final _userController = ref.watch(userControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("設定"), actions: [
        IconButton(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            onPressed: () {
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Screen()));
            }),
      ]),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Container(
            alignment: Alignment.center,
            width: 340,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
                onTap: () async {
                  // 投稿データを削除の処理
                  await _postController.deletePosts(_authState!.uid);
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Screen()));
                },
                child: Text(
                  "全ての投稿データを削除",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Center(
          child: Container(
            alignment: Alignment.center,
            width: 340,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
                onTap: () async {
                  // アカウントデータを削除の処理
                  await _userController.deleteAppUser(_authState!.uid);

                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Screen()));
                },
                child: Text(
                  "アカウントデータを削除",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
          ),
        )
      ]),
    );
  }
}
