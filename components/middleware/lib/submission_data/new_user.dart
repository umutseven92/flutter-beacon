import 'package:meta/meta.dart';

class NewUser {

  String uid, name, profilePicUrl, email, country, bio;
  double lat, lon;

  NewUser({
    @required this.uid,
    @required this.name,
    @required this.profilePicUrl,
    @required this.email,
  });

  bool isComplete() {
    return country != null && lat != null && lon != null && uid != null && name != null && profilePicUrl != null && email != null &&
    uid.length > 0 && name.length > 0 && profilePicUrl.length > 0  && email.length > 0  && country.length > 0;
  }

  Map<String, dynamic> toJson() => {
      'uid': uid,
      'name': name,
      'profile_pic_url': profilePicUrl,
      'email': email,
      'bio': bio,
      'lat' : lat,
      'lon' : lon,
      'country': country,
      'is_active' : false,
  };

}