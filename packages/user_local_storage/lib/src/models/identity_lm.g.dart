// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_lm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityLM _$IdentityLMFromJson(Map<String, dynamic> json) => IdentityLM(
      name: json['name'] as String,
      username: json['username'] as String,
      bio: json['bio'] as String,
      location: json['location'] as String,
      hireMeUrl: json['hire_me_url'] as String,
      imageUrl: json['image_url'] as String,
      socialList: (json['socials'] as List<dynamic>)
          .map((e) => SocialLM.fromJson(e as Map<String, dynamic>))
          .toList(),
      projectUrl: json['project_url'] as String,
      lud16: json['lud16'] as String,
    );

SocialLM _$SocialLMFromJson(Map<String, dynamic> json) => SocialLM(
      username: json['username'] as String,
      icon: json['icon'] as String,
      url: json['url'] as String,
    );
