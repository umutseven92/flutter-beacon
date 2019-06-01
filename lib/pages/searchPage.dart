import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/static/mockData.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class SearchPage extends StatelessWidget {
  final LatLng currentLocation = LatLng(51.534998, -0.122323);
  final R = 6372.8; // R constant for Haversine formula below

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }

  // Haversine formula for calculating distance between two points
  double _calculateDistance(LatLng distance) {
    double lat1 = currentLocation.latitude;
    double lat2 = distance.latitude;
    double lon1 = currentLocation.longitude;
    double lon2 = distance.longitude;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    lat1 = _toRadians(lat1);
    lat2 = _toRadians(lat2);
    double a =
        pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
    double c = 2 * asin(sqrt(a));
    return R * c;
  }

  List<Widget> _createUserList(List<User> users) {
    var mockList = <Widget>[];
    var distanceList = <UserDistanceDTO>[];

    users.forEach((user) {
      double distance = _calculateDistance(user.latLng);
      distanceList.add(UserDistanceDTO(user, distance));
    });

    distanceList.sort((a, b) => a.distance.compareTo(b.distance));

    distanceList.forEach((dto) {
      mockList.add(
          _createUserTile(dto.user.profilePic, dto.user.name, dto.user.email, dto.distance));
    });

    return mockList;
  }

  Widget _createUserTile(String profilePicURL, String name, String email, double distance) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        child: Image.network(
          profilePicURL,
          fit: BoxFit.cover,
        ),
      ),
      title: Text('$name ($email)'),
      subtitle: Text('${distance.toStringAsFixed(2)} km'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var users = MockData.getMockUsers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Closest Users'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView(
                children: _createUserList(users),
              ),
            ),
          )
        ],
      ),
    );
  }
}
