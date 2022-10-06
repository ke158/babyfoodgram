import 'package:babyfoodgram/presentation_layer/views/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation_providers.dart';
import 'sign_up_page.dart';

class LoginPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();

    final _emailController = useTextEditingController(text: '');
    final _passwordController = useTextEditingController(text: '');

    // final _userController = ref.watch(appUserControllerProvider.notifier);
    // final _authState = ref.watch(authControllerProvider);
    final _authController = ref.watch(authControllerProvider.notifier);
    final _imageController = ref.watch(imageStateControllerProvider.notifier);

    return Scaffold(
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
                    const Text(
                      'ログインページ',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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
                    const SizedBox(height: 16.0),
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
                    const SizedBox(height: 28.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 1.0,
                          textStyle: TextStyle(
                            color: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: const Text('ログイン'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await _authController.signIn(
                              _emailController.text,
                              _passwordController.text,
                            );
                            // await _userController.fetchAppUser(_authState!.uid);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Screen()));
                          }
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
                        child: const Text('新規登録'),
                        onPressed: () async {
                          await _imageController.clearImage();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
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
