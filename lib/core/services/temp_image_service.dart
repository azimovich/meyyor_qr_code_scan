import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class TempImageService {
  static const String _fileName = 'temp_image.jpg';

  /// Rasmni cache papkasiga saqlaydi
  /// XFile dan vaqtincha rasmni cache'ga saqlaydi
  Future<File> saveTempImage(XFile xfile) async {
    final cacheDir = await getTemporaryDirectory();
    final tempPath = p.join(cacheDir.path, _fileName);
    final savedImage = await File(xfile.path).copy(tempPath);
    log('Save temp image in path -> ${savedImage.path}', name: 'TempImageService');
    return savedImage;
  }

  /// Cache'dan saqlangan temp rasmni oladi
  Future<File?> getTempImage() async {
    final cacheDir = await getTemporaryDirectory();
    final file = File(p.join(cacheDir.path, _fileName));
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  /// Cache'dagi temp rasmni o'chiradi
  Future<void> deleteTempImage() async {
    final cacheDir = await getTemporaryDirectory();
    final file = File(p.join(cacheDir.path, _fileName));
    if (await file.exists()) {
      log('Delete temp image in path -> ${file.path}', name: 'TempImageService');
      await file.delete();
    }
  }
}
