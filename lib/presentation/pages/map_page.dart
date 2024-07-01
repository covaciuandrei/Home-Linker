import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelinker/models/place_location.dart';

@RoutePage()
class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
    this.location = const PlaceLocation(
      latLng: LatLng(44.43, 26),
      address: '',
    ),
    this.isSelecting = true,
  });
  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isSelecting ? AppLocalizations.of(context).pickLocation : AppLocalizations.of(context).yourLocation),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                AutoRouter.of(context).maybePop(pickedLocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting
            ? (position) {
                setState(() {
                  pickedLocation = position;
                });
              }
            : null,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latLng.latitude, widget.location.latLng.longitude),
          zoom: 16,
        ),
        markers: pickedLocation == null && widget.isSelecting
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position:
                      pickedLocation ?? LatLng(widget.location.latLng.longitude, widget.location.latLng.longitude),
                ),
              },
      ),
    );
  }
}
