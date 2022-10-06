import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screen.dart';
import '../../presentation_providers.dart';

class SignUpPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = useTextEditingController(text: '');
    final _passwordController = useTextEditingController(text: '');
    final _userNameController = useTextEditingController(text: '');
    final _userIdController = useTextEditingController(text: '');

    final _authController = ref.watch(authControllerProvider.notifier);
    final _userController = ref.watch(userControllerProvider.notifier);
    final _imageController = ref.watch(imageStateControllerProvider.notifier);
    final _imageState = ref.watch(imageStateControllerProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("新規登録"),
      ),
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
                        await _imageController.setImage();
                      },
                      child: CircleAvatar(
                        foregroundImage: _imageState.image == null
                            ? null
                            : FileImage(_imageState.image!),
                        radius: 40,
                        child: Icon(Icons.add),
                      ),
                    ),
                    const SizedBox(height: 16.0),
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
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.multiline,
                      validator: (value) =>
                          value!.contains('@') ? null : 'メールアドレスを入力してください。',
                      decoration: InputDecoration(
                        labelText: 'メールアドレス',
                        alignLabelWithHint: true,
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.multiline,
                      validator: (value) =>
                          value!.length < 8 ? '8文字以上で入力してください' : null,
                      decoration: InputDecoration(
                        labelText: 'パスワード',
                        alignLabelWithHint: true,
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 28.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          textStyle: TextStyle(
                            color: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: const Text('新規登録'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            final result = await _authController.signUp(
                              _emailController.text,
                              _passwordController.text,
                            );

                            if (result != null) {
                              print("uid : ${result.uid}");
                              await _userController.createAppUser(
                                  result.uid,
                                  _userNameController.text,
                                  _userIdController.text,
                                  _imageState.image);

                              await _imageController.clearImage();
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Screen()));
                          }
                        }),
                    const SizedBox(height: 12.0),
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
