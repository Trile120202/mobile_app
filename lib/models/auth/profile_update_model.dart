import 'dart:convert';

ProfileUpdateReq profileUpdateReqFromJson(String str) => ProfileUpdateReq.fromJson(json.decode(str));

String profileUpdateReqToJson(ProfileUpdateReq data) => json.encode(data.toJson());

class ProfileUpdateReq {
  ProfileUpdateReq({
    required this.location,
    required this.username,
//    required this.phone,
  });

  final String location;
  final String username;
  //final String phone;

  factory ProfileUpdateReq.fromJson(Map<String, dynamic> json) => ProfileUpdateReq(
        location: json["location"],
        username: json["username"],
        //phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "username": username,
        //       "phone": phone,
      };
}
