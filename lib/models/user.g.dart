// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomUser _$CustomUserFromJson(Map<String, dynamic> json) => CustomUser(
      name: json['name'] as String,
      userId: json['userId'] as String,
      bio: json['bio'] as String,
      email: json['email'] as String,
      friends:
          (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CustomUserToJson(CustomUser instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'userId': instance.userId,
      'bio': instance.bio,
      'friends': instance.friends,
    };
