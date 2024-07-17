import 'dart:convert';

ProfileUpdateReq profileUpdateReqFromJson(String str) => ProfileUpdateReq.fromJson(json.decode(str));

String profileUpdateReqToJson(ProfileUpdateReq data) => json.encode(data.toJson());

class ProfileUpdateReq {
  ProfileUpdateReq({
    required this.location,
    required this.username,
  });

  final String location;
  final String username;

  factory ProfileUpdateReq.fromJson(Map<String, dynamic> json) => ProfileUpdateReq(
        location: json["location"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "username": username,
      };
}
