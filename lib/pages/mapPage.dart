import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_beacon/pages/searchPage.dart';
import 'package:flutter_beacon/pages/pages.dart';
import 'package:flutter_beacon/static/mockData.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:blocs/blocs.dart';
import 'dart:async';
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool activated;
  Set<Marker> _createMarkers(List<User> users) {
    Set<Marker> mockSet = Set();

    users.forEach((user) {
      mockSet.add(Marker(
          icon: !user.isActive
              ? BitmapDescriptor.defaultMarkerWithHue(0)
              : BitmapDescriptor.defaultMarkerWithHue(
                  200),
          markerId: MarkerId(user.id),
          position: user.latLng,
          infoWindow: InfoWindow(
              title: '${user.name} (${user.email})', snippet: user.bio)));
    });

    return mockSet;
  }

  void _navigateToProfilePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }
  List<StreamSubscription<dynamic>> _subscriptions;

  @override
  dispose(){
    _subscriptions?.forEach((subscription) => subscription.cancel());
    super.dispose();
  }
  @override
  void initState() {
    activated = false;
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {
    var users = MockData.getMockUsers();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: activated ? Colors.white: Colors.blue,
        label: Row(
          children: <Widget>[
            activated ? FlutterLogo() : Icon(Icons.code),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(activated ? 'Good Job!' : 'Start coding today!',
                style: TextStyle(
                  color: activated ? Colors.blue : Colors.white
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            activated = true;
          });
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () => _navigateToProfilePage(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.contacts),
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
