// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomUser _$CustomUserFromJson(Map<String, dynamic> json) => CustomUser(
      name: json['name'] as String,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'],
      bio: json['bio'] as String,
      email: json['email'] as String,
      friends: (json['friends'] as List<dynamic>)
          .map((e) => CustomUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomUserToJson(CustomUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'bio': instance.bio,
      'friends': instance.friends,
    };
