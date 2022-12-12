import 'dart:io';

import 'package:babyfoodgram/domain_layer/interfaces/repository/image_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/custom_exception.dart';

class ImageRepositoryImpl implements ImageRepository {
  ImageRepositoryImpl({
    required FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage;
  final FirebaseStorage _firebaseStorage;

  @override
  Future<XFile?> getImageFromGallery() async {
    try {
      ImagePicker picker = ImagePicker();
      return await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

// イメージの登録
  @override
  Future<String> uploadImage(String uid, String folderName, File? image) async {
    try {
      //　イメージの登録
      await _firebaseStorage.ref(folderName).child(uid).putFile(image!);
      //　URL取得
      String downloadUrl =
          await _firebaseStorage.ref("${folderName}${uid}").getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// イメージの削除
  @override
  Future<void> deleteUploadImage(String uid, String folderName) async {
    try {
      await _firebaseStorage.ref(folderName).child(uid).delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
