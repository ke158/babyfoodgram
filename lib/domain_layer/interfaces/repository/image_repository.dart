import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImageRepository {
  Future<XFile?> getImageFromGallery();
  Future<String> uploadImage(String uid, String folderName, File? image);
  Future<void> deleteUploadImage(String id, String folderName);
}
