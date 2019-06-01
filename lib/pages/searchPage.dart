import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class _User {
  final String id;
  final String name;
  final String profilePic;
  final String email;
  final LatLng latLng;
  final String country;
  final bool isActive;
  final String bio;

  _User(this.id, this.name, this.profilePic, this.email, this.latLng,
      this.country, this.isActive, this.bio);
}

class _UserDistanceDTO {
  final _User user;
  final double distance;

  _UserDistanceDTO(this.user, this.distance);
}

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

  List<Widget> _createUserList(List<_User> users) {
    var mockList = <Widget>[];
    var distanceList = <_UserDistanceDTO>[];

    users.forEach((user) {
      double distance = _calculateDistance(user.latLng);
      distanceList.add(_UserDistanceDTO(user, distance));
    });

    distanceList.sort((a, b) => a.distance.compareTo(b.distance));

    distanceList.forEach((dto) {
      mockList.add(
          _createUserTile(dto.user.profilePic, dto.user.name, dto.distance));
    });

    return mockList;
  }

  Widget _createUserTile(String profilePicURL, String name, double distance) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        child: Image.network(
          profilePicURL,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(name),
      subtitle: Text('${distance.toStringAsFixed(2)} km'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var users = <_User>[]
      ..add(_User(
          '1',
          'Umut Seven',
          'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F256FE13F54F1EE2A33',
          'umutseven92@gmail.com',
          LatLng(51.531913, -0.118822),
          'UK',
          true,
          'Lorem Ipsum'))
      ..add(_User(
          '2',
          'Eric Clapton',
          'https://www.imanami.com/wp-content/uploads/2016/03/unknown-user.jpg',
          'ericclapton@gmail.com',
          LatLng(51.530925, -0.122309),
          'UK',
          false,
          'Lorem Ipsum'));

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
