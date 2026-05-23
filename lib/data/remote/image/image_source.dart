import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homelinker/data/mappers/image_mapper.dart';
import 'package:homelinker/data/remote/image/image_dto.dart';
import 'package:homelinker/data/remote_source_names.dart';
import 'package:homelinker/models/image.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImagesSource {
  ImagesSource(this._imageMapper);

  final ImageMapper _imageMapper;

  CollectionReference<ImageDto> get _collectionRef =>
      FirebaseFirestore.instance.collection(RemoteSourceNames.images).withConverter<ImageDto>(
            fromFirestore: (snapshots, _) => ImageDto.fromJson(snapshots.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Future<List<Image>> getAll() async {
    final querySnapshot = await _collectionRef.get();
    final imageDtos = querySnapshot.docs.map((doc) => doc.data()).toList();

    return _imageMapper.mapImageDtos(imageDtos);
  }

  Future<Image?> get({required String imageId}) async {
    final normalizedImageId = imageId.trim();
    if (normalizedImageId.isEmpty) return null;

    final imageDto = (await _collectionRef.doc(normalizedImageId).get()).data();
    if (imageDto == null) return null;

    return _imageMapper.mapDtoToImage(imageDto);
  }

  Future<String> insert(Image newImage) async {
    final imageDto = _imageMapper.mapImageToDto(newImage);
    final documentRef = await _collectionRef.add(imageDto);
    return documentRef.id;
  }

  Future<void> delete({required String imageId}) async {
    final normalizedImageId = imageId.trim();
    if (normalizedImageId.isEmpty) return;

    final documentRef = _collectionRef.doc(normalizedImageId);
    await documentRef.delete();
  }
}
