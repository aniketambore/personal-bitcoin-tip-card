import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home/src/launch_url.dart';
import 'package:user_repository/user_repository.dart';

class ProfileIdentity extends StatelessWidget {
  ProfileIdentity({
    super.key,
    required this.pushToTip,
    @visibleForTesting LaunchUrl? launchUrl,
    required this.userRepository,
  }) : _launchUrl = LaunchUrl();

  final VoidCallback pushToTip;
  final LaunchUrl _launchUrl;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.separated(
          itemCount: userRepository.socialList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _launchUrl.launch(userRepository.socialList[index].url);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    userRepository
                        .getIconPath(userRepository.socialList[index].icon),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    userRepository.socialList[index].username,
                    style: const TextStyle(
                      color: royalBlue,
                      fontSize: FontSize.mediumLarge,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, i) {
            return const SizedBox(
              height: Spacing.medium,
            );
          },
        ),
        const SizedBox(
          height: Spacing.large,
        ),
        ExpandedElevatedButton(
          label: 'Tip Bitcoin',
          onTap: pushToTip,
        ),
      ],
    );
  }
}
