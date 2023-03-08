import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home/src/desktop_view.dart';
import 'package:home/src/launch_url.dart';
import 'package:home/src/mobile_view.dart';
import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.pushToTip,
    required this.userRepository,
    @visibleForTesting LaunchUrl? launchUrl,
  }) : _launchUrl = LaunchUrl();

  final VoidCallback pushToTip;
  final UserRepository userRepository;
  final LaunchUrl _launchUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: white,
        onPressed: () {
          _launchUrl.launch(userRepository.getProjectUrl);
        },
        child: SvgPicture.asset('assets/github.svg'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return MobileView(
              pushToTip: pushToTip,
              userRepository: userRepository,
            );
          } else {
            return DesktopView(
              pushToTip: pushToTip,
              userRepository: userRepository,
            );
          }
        },
      ),
    );
  }
}
