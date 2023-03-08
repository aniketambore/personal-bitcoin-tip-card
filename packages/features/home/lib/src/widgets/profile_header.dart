import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:home/src/launch_url.dart';
import 'package:user_repository/user_repository.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({
    super.key,
    @visibleForTesting LaunchUrl? launchUrl,
    required this.userRepository,
  }) : _launchUrl = LaunchUrl();

  final LaunchUrl _launchUrl;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Circular Image
        CircleAvatar(
          radius: 76,
          backgroundColor: orange,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userRepository.getImageUrl,
            ),
            radius: 73,
            onBackgroundImageError: (e, s) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Unable to load image.'),
                    backgroundColor: flamingo,
                  ),
                );
            },
          ),
        ),
        const SizedBox(
          height: Spacing.large,
        ),
        // Full Name
        Column(
          children: [
            SelectableText(
              userRepository.getUsername,
              style: const TextStyle(
                fontSize: FontSize.mediumLarge,
                fontWeight: FontWeight.w700,
                color: orange,
              ),
            ),
            SelectableText(
              userRepository.getName,
              style: const TextStyle(
                fontSize: FontSize.mediumLarge,
                fontWeight: FontWeight.w600,
                color: tundora,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: Spacing.medium,
        ),
        // Bio
        SelectableText(
          userRepository.getBio,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: FontSize.medium,
            color: tundora,
          ),
        ),
        const SizedBox(
          height: Spacing.small,
        ),
        // Location
        SelectableText(
          userRepository.getLocation,
          style: const TextStyle(
            fontSize: FontSize.medium,
            color: tundora,
          ),
        ),
        const SizedBox(
          height: Spacing.large,
        ),
        ExpandedOutlinedButton(
          label: 'Hire Me',
          onTap: () {
            _launchUrl.launch(userRepository.getHireMeUrl);
          },
        ),
      ],
    );
  }
}
