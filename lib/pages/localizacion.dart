import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
// Clase que implementa un mapa para mostrar la ubicación de la barberia
class Localizacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
          options: MapOptions(
            center:  LatLng(37.8664807, -4.7838423),
            minZoom: 15,
            maxZoom: 15,
            zoom: 15,
          ),
          layers: [
            new TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
                  "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoicnVqZXgiLCJhIjoiY2p1MWhpejFrMDFtMzQxbW5kOGg4ajJrdSJ9.DfqDCGs1ye-aNI9XymisgQ',
                'id': 'mapbox.streets',
              },
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(37.8664807, -4.7838423),
                  builder: (ctx) =>
                  new Container(
                    child: IconButton(
                      onPressed: () {
                        print('has presionado');
                      },
                      icon: Icon(Icons.location_on),
                      iconSize: 45.0,
                      color: Colors.red
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}