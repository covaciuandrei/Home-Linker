import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homelinker/data/mappers/image_mapper.dart';
import 'package:homelinker/data/remote/image/image_dto.dart';
import 'package:homelinker/data/remote/storage/storage_source.dart';
import 'package:homelinker/data/remote_source_names.dart';
import 'package:homelinker/models/image.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImagesSource {
  ImagesSource(this._imageMapper, this._storageSource);

  final ImageMapper _imageMapper;
  final StorageSource _storageSource;

  CollectionReference<ImageDto> get _collectionRef => FirebaseFirestore.instance
      .collection(RemoteSourceNames.images)
      .withConverter<ImageDto>(
        fromFirestore: (snapshots, _) => ImageDto.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future<List<Image>> getAll() async {
    final querySnapshot = await _collectionRef.get();
    final imageDtos = querySnapshot.docs.map((doc) => doc.data()).toList();

    return _imageMapper.mapImageDtos(imageDtos);
  }
  Future<Image> get({required String imageId}) async {
    final imageDto = (await _collectionRef.doc(imageId) .get()).data();

    return _imageMapper.mapDtoToImage(imageDto!);
  }
 


  Future<String> insert(Image newImage) async {
    final imageDto = _imageMapper.mapImageToDto(newImage);
    final documentRef = await _collectionRef.add(imageDto);
    return documentRef.id;
  }

  
}
