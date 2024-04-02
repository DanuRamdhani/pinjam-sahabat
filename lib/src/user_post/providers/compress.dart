import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class Compress {
  static Future<File?> compressImage(File file) async {
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${Directory.systemTemp.path}/compressed_image.jpg',
      quality: 88,
    );

    return File(compressedFile!.path);
  }
}
