import 'package:json_annotation/json_annotation.dart';

part 'identity_lm.g.dart';

@JsonSerializable(createToJson: false)
class IdentityLM {
  const IdentityLM({
    required this.name,
    required this.username,
    required this.bio,
    required this.location,
    required this.hireMeUrl,
    required this.imageUrl,
    required this.socialList,
    required this.projectUrl,
    required this.lud16,
  });

  final String name;
  final String username;
  final String bio;
  final String location;
  @JsonKey(name: 'hire_me_url')
  final String hireMeUrl;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'socials')
  final List<SocialLM> socialList;
  @JsonKey(name: 'project_url')
  final String projectUrl;
  final String lud16;

  static const fromJson = _$IdentityLMFromJson;
}

@JsonSerializable(createToJson: false)
class SocialLM {
  const SocialLM({
    required this.username,
    required this.icon,
    required this.url,
  });

  final String username;
  final String icon;
  final String url;

  static const fromJson = _$SocialLMFromJson;
}
