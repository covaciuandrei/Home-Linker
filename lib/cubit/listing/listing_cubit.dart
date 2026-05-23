import 'package:homelinker/cubit/base_cubit.dart';
import 'package:homelinker/cubit/base_state.dart';
import 'package:homelinker/models/property.dart';
import 'package:homelinker/services/image/image_service.dart';
import 'package:homelinker/services/property/property_service.dart';
import 'package:homelinker/services/user/user_service.dart';
import 'package:injectable/injectable.dart';

part 'package:homelinker/cubit/listing/listing_states.dart';

@injectable
class ListingCubit extends BaseCubit {
  ListingCubit(this._propertyService, this._imageService, this._userService)
      : super(InitialState());

  final PropertyService _propertyService;
  final ImageService _imageService;
  final UserService _userService;

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

  Future<void> addFavorite({required String id}) async {
    safeEmit(PendingState());
    try {
      await _userService.addListingToFavorites(id: id);
      safeEmit(ListingFavoritedState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
  }

  Future<void> removeFavorite({required String id}) async {
    safeEmit(PendingState());
    try {
      await _userService.removeListingToFavorites(id: id);
      safeEmit(ListingUnfavoritedState());
    } on Exception {
      safeEmit(SomethingWentWrongState());
    }
  }
}
