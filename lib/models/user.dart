import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String email;
  final String name;
  final String username;
  final dynamic phoneNumber;
  final String bio;

  User({
    required this.name,
    required this.username,
    required this.phoneNumber,
    required this.bio,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
