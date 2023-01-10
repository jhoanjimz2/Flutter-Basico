// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: use_key_in_widget_constructors
class MapaScreen extends StatefulWidget {

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    //final ScanModel scan = ModalRoute.of(context)?.settings.arguments;
    // ignore: unused_local_variable
    final CameraPosition puntoInicial = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 17,
      tilt: 50
    );
    

    Set<Marker> markers = <Marker>{};
    // ignore: unnecessary_new
    markers.add(new Marker(
      markerId: MarkerId('geo-location'),
      position: LatLng(37.42796133580664, -122.085749655962)
    ));

    
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_disabled),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 17.5,
                    tilt: 50
                  )
                )
              );
            },
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        markers: markers,
        mapType: mapType,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          if ( mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }
          setState(() {});
        },
      ),
    );
  }
}
