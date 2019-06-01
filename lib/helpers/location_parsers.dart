import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';

class LocationParsers {

  static final String _citiesPath = 'assets/cities.json';
  final int GEOHASH_ACCURACY_LENGTH = 6;

  List<City> cities;

  static final LocationParsers _singleton = new LocationParsers._internal();
  static BuildContext _context;

  factory LocationParsers(BuildContext context) {
    _context = context;
    return _singleton;
    
  }

  LocationParsers._internal() {
    DefaultAssetBundle.of(_context).loadString(_citiesPath).then((res) {
      cities = List<City>.from(json.decode(res).map((countryMap) => City.fromJson(countryMap)).toList());
    });
  }

  City getNearestCity(double lat, double lng) {
    City nearestCity;
    double nearestDistance = 1000000.0;
    cities.forEach((city) {
      double distance = city.getDistanceToPoint(lat, lng);
      if(distance < nearestDistance){
        nearestCity = city;
        nearestDistance = distance;
      }
    });
    return nearestCity;
  }

}

class City {
  
  final String country, name, geohash;
  final double lat, lng;

  City.fromJson(Map<String, dynamic> json)
    : country = json['country'],
      name = json['name'],
      lat = double.parse(json['lat']),
      lng = double.parse(json['lng']),
      geohash = json['geohash'];


  String toString() => "$name, $country";

  double getDistanceToPoint(double otherLat, double otherLng){
    return pow(pow(lat - otherLat, 2) + pow(lng - otherLng, 2), 0.5);
  }

}