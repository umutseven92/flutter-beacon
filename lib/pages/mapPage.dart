import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/pages/searchPage.dart';
import 'package:flutter_beacon/static/mockData.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  Set<Marker> _createMarkers(List<User> users) {
    Set<Marker> mockSet = Set();

    users.forEach((user) {
      mockSet.add(Marker(
          icon: !user.isActive
              ? BitmapDescriptor.defaultMarker
              : BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
          markerId: MarkerId(user.id),
          position: user.latLng,
          infoWindow: InfoWindow(
              title: '${user.name} (${user.email})', snippet: user.bio)));
    });

    return mockSet;
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var users = MockData.getMockUsers();

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
              markers: _createMarkers(users),
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(51.531888, -0.118813), zoom: 15),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 150,
              height: 60,
              child: Card(
                child: Center(
                    child: Text(
                  '${users.where((user) => user.isActive).length} active',
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
