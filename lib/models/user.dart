import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class CustomUser {
  final String email;
  final String name;
  final String userId;
  final String bio;
  final String imageUrl;
  final List<String> friends;

  CustomUser({
    required this.name,
    required this.imageUrl,
    required this.userId,
    required this.bio,
    required this.email,
    required this.friends,
  });

  factory CustomUser.fromJson(Map<String, dynamic> json) =>
      _$CustomUserFromJson(json);

  Map<String, dynamic> toJson() => _$CustomUserToJson(this);
}
