// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'],
      bio: json['bio'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'bio': instance.bio,
    };
