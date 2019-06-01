class User {


  String uid, name, profilePicUrl, email, country, bio;
  bool isActive;
  double lat, lon;

  User.fromMap(Map<String, dynamic> map){
    uid = map['uid'].toString();
    name = map['name'];
    profilePicUrl = map['profile_pic_url'];
    email = map['email'];
    country = map['country'];
    bio = map['bio'];
    isActive =map['is_active'];
    lat =map['lat'];
    lon = map['lon'];
  } 

  Map<String, dynamic> toJson({bool cache = false}) => {
    'uid' : uid, 
    'name' : name,
    'profile_pic_url' : profilePicUrl,
  };
}