import 'package:equatable/equatable.dart';

class Identity extends Equatable {
  const Identity({
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
  final String hireMeUrl;
  final String imageUrl;
  final List<Social> socialList;
  final String projectUrl;
  final String lud16;

  @override
  List<Object?> get props => [
        name,
        username,
        bio,
        location,
        hireMeUrl,
        imageUrl,
        socialList,
        projectUrl,
        lud16,
      ];
}

class Social extends Equatable {
  const Social({
    required this.username,
    required this.icon,
    required this.url,
  });

  final String username;
  final String icon;
  final String url;

  @override
  List<Object?> get props => [
        username,
        icon,
        url,
      ];
}
