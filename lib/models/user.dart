import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class CustomUser {
  final String email;
  final String name;
  final String username;
  final dynamic phoneNumber;
  final String bio;
  final List<String> friends;

  CustomUser({
    required this.name,
    required this.username,
    required this.phoneNumber,
    required this.bio,
    required this.email,
    required this.friends,
  });

  factory CustomUser.fromJson(Map<String, dynamic> json) =>
      _$CustomUserFromJson(json);

  Map<String, dynamic> toJson() => _$CustomUserToJson(this);
}
