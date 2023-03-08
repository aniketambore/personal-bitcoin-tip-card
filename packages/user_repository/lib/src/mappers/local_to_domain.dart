import 'package:domain_models/domain_models.dart';
import 'package:user_local_storage/user_local_storage.dart';

extension IdentityLMtoDomain on IdentityLM {
  Identity toDomainModel() {
    return Identity(
      name: name,
      username: username,
      bio: bio,
      location: location,
      hireMeUrl: hireMeUrl,
      imageUrl: imageUrl,
      socialList: socialList
          .map(
            (social) => social.toDomainModel(),
          )
          .toList(),
      projectUrl: projectUrl,
    );
  }
}

extension SocialLMtoDomain on SocialLM {
  Social toDomainModel() {
    return Social(
      username: username,
      icon: icon,
      url: url,
    );
  }
}
