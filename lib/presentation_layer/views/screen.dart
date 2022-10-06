import 'package:babyfoodgram/presentation_layer/views/start_up/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure_layer/infrastructure_providers.dart';
import '../presentation_providers.dart';
import 'upload/time_line_page.dart';
import 'upload/upload_page.dart';

class Screen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final _userState = ref.watch(appUserControllerProvider);
    final _authState = ref.watch(authStreamProvider);
    final _imageController = ref.watch(imageStateControllerProvider.notifier);
    return _authState.when(data: (data) {
      if (data != null) {
        return Scaffold(
            body: TimeLinePage(),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await _imageController.clearImage();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadPage(),
                  ),
                );
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.add), Text("投稿")],
                ),
              ),
            ));
      } else {
        return LoginPage();
      }
    }, loading: () {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }, error: (_, __) {
      return const Scaffold(
        body: Center(
          child: Text('エラー'),
        ),
      );
    });
  }
}
