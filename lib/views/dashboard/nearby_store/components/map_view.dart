import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.shopName,
  });
  final double latitude;
  final double longitude;
  final String shopName;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _kGooglePlex;
  BitmapDescriptor? _bitmapDescriptor;

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 16.4746,
    );
    getMarker();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> getMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/png/pin.png', 70);

    // ignore: deprecated_member_use
    _bitmapDescriptor = BitmapDescriptor.fromBytes(markerIcon);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_bitmapDescriptor == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return GoogleMap(
      mapType: MapType.terrain,
      compassEnabled: true,
      myLocationButtonEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      mapToolbarEnabled: true,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: {
        Marker(
          markerId: const MarkerId('customerMarker'),
          position: LatLng(widget.latitude, widget.longitude),
          icon: _bitmapDescriptor!,
          infoWindow: InfoWindow(
            title: widget.shopName,
          ),
          anchor: const Offset(0.5, 1),
        ),
      },
    );
  }
}
