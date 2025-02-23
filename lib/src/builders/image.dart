import 'dart:convert';
import 'package:nyxx_self/src/errors.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:path/path.dart' as p;

class ImageBuilder {
  List<int> data;
  String format;

  ImageBuilder({required this.data, required this.format});

  ImageBuilder.png(this.data) : format = 'png';

  ImageBuilder.jpeg(this.data) : format = 'jpeg';

  ImageBuilder.gif(this.data) : format = 'gif';

  static Future<ImageBuilder> fromFile(File file, {String? format}) async {
    if (kIsWeb) {
      throw JsDisabledError('ImageBuilder.fromFile');
    }

    format ??= p.extension(file.path);

    const formats = {
      'png': 'png',
      'jpeg': 'jpeg',
      'jpg': 'jpeg',
      'gif': 'gif',
      'json': 'lottie',
    };

    final actualFormat = formats[format];

    if (actualFormat == null) {
      throw ArgumentError('Invalid format $format');
    }

    final data = await file.readAsBytes();

    return ImageBuilder(data: data, format: actualFormat);
  }

  String buildDataString() => 'data:image/$format;base64,${base64Encode(data)}';

  List<int> buildRawData() => data;
}
