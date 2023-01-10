import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

class FullMapScreen extends StatefulWidget {
  static const String routerName = '';
  const FullMapScreen({Key? key}) : super(key: key);

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {
  MapboxMapController? mapController;
  final LatLng center = const LatLng(37.4019603,-122.6154405);
  final oscuroStyle = 'mapbox://styles/jhoanjimz2/clc3wbqju002n14n22voomp30';
  final streetStyle = 'mapbox://styles/jhoanjimz2/clc3wfcxd000g14o3g1f8pvge';
  var isLight = true;

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", Uri.parse("https://via.placeholder.com/50"));
  }
  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController!.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes()
    );
  }

  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.sentiment_very_dissatisfied),
          onPressed: () {
            mapController!.addSymbol( SymbolOptions(
              geometry: center,
              iconImage: 'assetImage',
              //iconImage: 'networkImage',
              textField: 'Montaña creada aquí',
              textOffset: const Offset(0,2)
            ));
            setState(() { });
          },
        ),
        const SizedBox(height: 5),
        FloatingActionButton(
          child: const Icon(Icons.zoom_in),
          onPressed: () {
            mapController!.animateCamera(CameraUpdate.zoomIn());
            setState(() { });
          },
        ),
        const SizedBox(height: 5),
        FloatingActionButton(
          child: const Icon(Icons.zoom_out),
          onPressed: () {
            mapController!.animateCamera(CameraUpdate.zoomOut());
            setState(() { });
          },
        ),
        const SizedBox(height: 5),
        FloatingActionButton(
          child: const Icon(Icons.swap_horiz),
          onPressed: () => setState(
            () => {isLight = !isLight , _onStyleLoaded()},
          ),
        )
      ]
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: isLight ? streetStyle : oscuroStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 14
      )
    );
  }
}