import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/services/image/image_service.dart';
import 'package:homelinker/services/property/property_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/listing/listing_states.dart';

@injectable
class ListingCubit extends BaseCubit {
  ListingCubit(this._propertyService, this._imageService)
      : super(InitialState());

  final PropertyService _propertyService;
  final ImageService _imageService;

  Future<void> loadPage() async {
    safeEmit(PendingState());

    Future.delayed(
        const Duration(milliseconds: 50), () => safeEmit(ListingLoadedState()));
  }

  Future<void> deleteListing({required Property property}) async {
    safeEmit(PendingState());

    try {
      await _imageService.delete(imageId: property.imageId);
      await _propertyService.delete(propertyId: property.id);
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
    safeEmit(ListingDeletedState());
  }
}
