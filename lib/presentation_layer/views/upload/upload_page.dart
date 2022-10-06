import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation_providers.dart';

class UploadPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();

    final _titleController = useTextEditingController(text: '');
    final _contentController = useTextEditingController(text: '');
    final _authState = ref.watch(authControllerProvider);
    final _postController = ref.watch(postControllerProvider.notifier);
    final _imageController = ref.watch(imageStateControllerProvider.notifier);
    final _imageState = ref.watch(imageStateControllerProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('投稿ページ'),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                        child: Container(
                          width: double.infinity,
                          child: _imageState.image == null
                              ? CircleAvatar(
                                  radius: 40,
                                  child: Icon(Icons.add),
                                )
                              : Image(image: FileImage(_imageState.image!)),
                        ),
                      ),
                      const SizedBox(height: 28.0),
                      TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.multiline,
                        validator: (value) =>
                            value!.trim().isEmpty ? 'タイトルを入力してください。' : null,
                        decoration: InputDecoration(
                          labelText: 'レシピのタイトル',
                          alignLabelWithHint: true,
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 28.0),
                      TextFormField(
                        controller: _contentController,
                        keyboardType: TextInputType.multiline,
                        minLines: 12,
                        maxLines: 12,
                        validator: (value) =>
                            value!.trim().isEmpty ? '投稿内容を入力してください。' : null,
                        decoration: InputDecoration(
                          labelText: 'レシピの内容（作り方・材料）',
                          alignLabelWithHint: true,
                        ),
                        style: TextStyle(
                          fontSize: 14.0,
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
                          child: const Text('投稿'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await _postController.createPost(
                                  _authState!.uid,
                                  _titleController.text,
                                  _contentController.text,
                                  _imageState.image);
                              Navigator.pop(context);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
