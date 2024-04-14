import 'package:homelinker/data/remote/image/image_dto.dart';
import 'package:homelinker/models/image.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImageMapper {
  Image mapDtoToImage(ImageDto dto) => Image(
        name: dto.name,
        path: dto.path,
        uploadDate: dto.uploadDate,
      );

  List<Image> mapImageDtos(List<ImageDto> imageDtos) =>
      imageDtos.map(mapDtoToImage).toList();

  ImageDto mapImageToDto(Image image) => ImageDto(
        image.name,
        image.path,
        image.uploadDate,
      );
  List<ImageDto> mapImagesToDtos(List<Image> images) =>
      images.map(mapImageToDto).toList();
}
