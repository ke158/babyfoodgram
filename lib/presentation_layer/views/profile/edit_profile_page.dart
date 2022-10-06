// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation_providers.dart';

class EditProfilePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();

    final _userState = ref.watch(userControllerProvider);
    final _userController = ref.watch(userControllerProvider.notifier);

    final _userNameController =
        useTextEditingController(text: _userState.userName);
    final _userIdController = useTextEditingController(text: _userState.userId);
    final _selfIntroductionController =
        useTextEditingController(text: _userState.selfIntroduction);

    final _imageController = ref.watch(imageStateControllerProvider.notifier);
    final _imageState = ref.watch(imageStateControllerProvider);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("編集ページ")),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_imageState.image == null) {
                          await _imageController.setImage();
                        }
                      },
                      child: CircleAvatar(
                        foregroundImage: _imageState.image == null
                            ? null
                            : FileImage(_imageState.image!),
                        radius: 40,
                        child: _userState.profileImage ==
                                _userState.profileImage
                            ? Image(
                                image:
                                    NetworkImage("${_userState.profileImage}"))
                            : Icon(Icons.add),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.multiline,
                      validator: (value) =>
                          value!.trim().isEmpty ? 'ユーザー名を入力してください。' : null,
                      decoration: InputDecoration(
                        labelText: 'ユーザー名',
                        alignLabelWithHint: true,
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _userIdController,
                      keyboardType: TextInputType.multiline,
                      validator: (value) =>
                          value!.trim().isEmpty ? 'ユーザーId名を入力してください。' : null,
                      decoration: InputDecoration(
                        labelText: 'ユーザーId',
                        alignLabelWithHint: true,
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _selfIntroductionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 5,
                      validator: (value) =>
                          value!.trim().isEmpty ? '自己紹介を入力してください。' : null,
                      decoration: InputDecoration(
                        labelText: '自己紹介',
                        alignLabelWithHint: true,
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          textStyle: TextStyle(
                            color: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: const Text('編集'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (_imageState.image == null) {
                              await _userController.updateAppUser(
                                  "${_userState.id}",
                                  _userNameController.text,
                                  _userIdController.text,
                                  _selfIntroductionController.text,
                                  _imageState.image,
                                  _userState.profileImage);
                            } else {
                              await _userController.updateAppUser(
                                  "${_userState.id}",
                                  _userNameController.text,
                                  _userIdController.text,
                                  _selfIntroductionController.text,
                                  _imageState.image,
                                  null);
                            }
                          }
                          Navigator.pop(context);
                        }),
                    const SizedBox(height: 28.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          textStyle: TextStyle(
                            color: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: const Text('キャンセル'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
