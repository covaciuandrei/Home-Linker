import 'package:drift/drift.dart';

class Image {
  Image({
    required this.name,
    required this.path,
    required this.uploadDate,
    this.data,
  });
  final String name;
  final String path;
  final DateTime uploadDate;
  final Uint8List? data;
}
