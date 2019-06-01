import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:random_words/random_words.dart';
import 'dart:math';

class MockData {
  static List<User> getMockUsers() {
    var users = <User>[];

    for (int i = 0; i < 2000; i++) {
      var rand = Random();
      var randomUser = User(
          '$i',
          '${WordPair.random().asPascalCase}',
          'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F256FE13F54F1EE2A33',
          '${WordPair.random().asLowerCase}@gmail.com',
          LatLng(-90 + 1.0 * rand.nextInt(180),-180 + 1.0 * rand.nextInt(360)),
          'UK',
          rand.nextBool(),
          'Developer who loves flutter!');

      users.add(randomUser);
    }

    return users;
  }

/*
  static List<User> users = <User>[]
    ..add(User(
        '1',
        'Umut Seven',
        'https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F256FE13F54F1EE2A33',
        'umutseven92@gmail.com',
        LatLng(51.531913, -0.118822),
        'UK',
        true,
        'Lorem Ipsum'))
    ..add(User(
        '2',
        'Eric Clapton',
        'https://www.imanami.com/wp-content/uploads/2016/03/unknown-user.jpg',
        'ericclapton@gmail.com',
        LatLng(51.530925, -0.122309),
        'UK',
        false,
        'Lorem Ipsum'));

*/
}

class UserDistanceDTO {
  final User user;
  final double distance;

  UserDistanceDTO(this.user, this.distance);
}

class User {
  final String id;
  final String name;
  final String profilePic;
  final String email;
  final LatLng latLng;
  final String country;
  final bool isActive;
  final String bio;

  User(this.id, this.name, this.profilePic, this.email, this.latLng,
      this.country, this.isActive, this.bio);
}
