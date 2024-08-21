import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? imageUrl;
  List<String>? followers;
  List<String>? following;
  List<String>? like;
  List<String>? comment;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.imageUrl,
    this.followers,
    this.following,
    required List<dynamic> like,
    required List comment,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    imageUrl: json["imageUrl"],
    followers: json["followers"] == null ? [] : List<String>.from(json["followers"]!.map((x) => x)),
    following: json["following"] == null ? [] : List<String>.from(json["following"]!.map((x) => x)),
    like: json["like"] == null ? [] : List<String>.from(json["like"]!.map((x) => x)),
    comment: json["comment"] == null ? [] : List<String>.from(json["comment"]!.map((x) => x)),

  );

  Map<String, dynamic> toJson() => {
  "id": id,
  "name": name,
  "email": email,
  "phone": phone,
  "imageUrl": imageUrl,
  "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x)),
  "following": following == null ? [] : List<dynamic>.from(following!.map((x)=>x)),
  };
}
