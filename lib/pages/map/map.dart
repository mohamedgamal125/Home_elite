import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:home_elite/tabs/add_ads/buy_ads/add_buy_ads_cubit.dart';
import 'package:home_elite/tabs/add_ads/rent_ads/add_rent_ads_cubit.dart'; // For reverse geocoding

class Maps extends StatefulWidget {

  final String flag;

  Maps({required this.flag});

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  String _selectedPlaceName = '';

  Marker? _selectedMarker;

  bool _showButtons = false;


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.0444, 31.2357), // Cairo, Egypt coordinates
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

  }

  Future<void> _handleTap(LatLng tappedPoint) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(tappedPoint.latitude, tappedPoint.longitude);

    String placeName = 'Unknown location';
    if (placemarks.isNotEmpty) {
      placeName = placemarks.first.name ?? placeName;
    }

    setState(() {
      _selectedMarker = Marker(
        markerId: MarkerId('selected_location'),
        position: tappedPoint,
        infoWindow: InfoWindow(
          title: 'Selected Location',
          snippet: _selectedPlaceName,
        ),
      );
      _showButtons = true; // Show buttons when a location is selected
    });

    _selectedPlaceName = await fetchAddress(_selectedMarker!.position.latitude, _selectedMarker!.position.longitude);
    print("=======Selected Location is ====== $_selectedPlaceName");
  }

  // Function to handle OK button click
  void _handleOk() {
    Navigator.pop(context, _selectedPlaceName);
  }

  // Function to handle Cancel button click
  void _handleCancel() {
    setState(() {
      _selectedMarker = null; // Remove the marker
      _selectedPlaceName = ''; // Clear the place name
      _showButtons = false; // Hide buttons
    });
  }

  @override
  Widget build(BuildContext context) {
    final buycubit = context.read<AddBuyAdsCubit>();
    final Rentcubit = context.read<AddRentAdsCubit>();
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _selectedMarker != null ? {_selectedMarker!} : {}, // Show the marker
            onTap: _handleTap, // Capture taps on the map
          ),
          if (_showButtons) // Show buttons if a location is selected
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      if(widget.flag=="buy")
                        {
                          buycubit.location.text=_selectedPlaceName;
                        }
                      else if(widget.flag=="rent")
                        {
                          Rentcubit.location.text=_selectedPlaceName;
                        }

                      Navigator.pop(context);
                    }, // OK button action
                    child: Text('OK'),
                  ),
                  ElevatedButton(
                    onPressed: _handleCancel, // Cancel button action
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<String> fetchAddress(double lat, double lng) async {
    const String apiKey = 'bdc_b3e97d1f21a74b2cb7f1f342b42b9c31';
    String apiUrl = 'https://api-bdc.net/data/reverse-geocode?latitude=$lat&longitude=$lng&key=$apiKey';

    try {
      Response response = await Dio().get(apiUrl);

      if (response.statusCode == 200) {
        final data = response.data;
        String locality = data['locality'] ?? '';
        String city = data['city'] ?? '';
        String countryName = data['countryName'] ?? '';

        String result = locality+" " +city+" "+countryName;

        print("=========================Address======== $result");
        return result;
      }

      return "Invalid location";
    } catch (e) {
      return "Invalid Location";
    }
  }
}
