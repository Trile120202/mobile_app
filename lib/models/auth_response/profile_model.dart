import 'dart:convert';

ProfileRes profileResFromJson(String str) => ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
  ProfileRes({
    this.id,
    this.username,
    this.email,
    this.location,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.lastLoginAt,
  });

  final String? id;
  final String? username;
  final String? email;
  final String? location;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLoginAt;

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
    id: json["data"]["id"],
    username: json["data"]["username"],
    email: json["data"]["email"],
    location: json["data"]["location"],
    status: json["data"]["status"],
    createdAt: DateTime.parse(json["data"]["createdAt"]),
    updatedAt: DateTime.parse(json["data"]["updatedAt"]),
    lastLoginAt: DateTime.parse(json["data"]["lastLoginAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "location": location,
    "status": status,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "lastLoginAt": lastLoginAt!.toIso8601String(),
  };
}