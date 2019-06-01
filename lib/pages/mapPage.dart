import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/pages/searchPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  Set<Marker> _createMockMarkerSet() {
    Set<Marker> mockSet = Set()
      ..add(Marker(
          markerId: MarkerId('Marker1'),
          position: LatLng(51.531888, -0.118813),
          infoWindow: InfoWindow(
              title: 'User Name',
              snippet:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')))
      ..add(Marker(
          markerId: MarkerId('Marker2'),
          position: LatLng(51.513711, -0.127904),
          infoWindow: InfoWindow(
              title: 'User Name',
              snippet:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')))
      ..add(Marker(
          markerId: MarkerId('Marker3'),
          position: LatLng(51.495740, -0.134286),
          infoWindow: InfoWindow(
              title: 'User Name',
              snippet:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')))
      ..add(Marker(
          markerId: MarkerId('Marker4'),
          position: LatLng(51.405402, -0.713446),
          infoWindow: InfoWindow(
              title: 'User Name',
              snippet:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')))
      ..add(Marker(
          markerId: MarkerId('Marker5'),
          position: LatLng(51.451142, -2.639136),
          infoWindow: InfoWindow(
              title: 'User Name',
              snippet:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')));

    return mockSet;
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Start coding!'),
        icon: Icon(Icons.code),
        onPressed: () {},
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _navigateToSearchPage(context),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: GoogleMap(
              markers: _createMockMarkerSet(),
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(51.531888, -0.118813), zoom: 15),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            
            child:
              Container(
                width: 150,
                height: 60,
                child: Card(
                  child: Center(
                      child: Text(
                    '300 active',
                    style: TextStyle(fontSize: 22),
                  )),
                ),
              ),
            ),
          
        ],
      ),
    );
  }
}
