import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Localizacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
          options: MapOptions(
            center:  LatLng(37.8655938, -4.784703899999999),
            zoom: 14.0,
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
                  point: new LatLng(37.8655938, -4.784703899999999),
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