import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

class Image extends Equatable {
  const Image({
    required this.name,
    required this.path,
    required this.uploadDate,
    this.data,
  });
  final String name;
  final String path;
  final DateTime uploadDate;
  final Uint8List? data;

  @override
  List<Object?> get props => [name, path, uploadDate, data];
}
