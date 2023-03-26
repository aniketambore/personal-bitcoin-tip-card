import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:home/src/unit_selector.dart';
import 'package:home/src/widgets/profile_header.dart';
import 'package:home/src/widgets/profile_identity.dart';
import 'package:user_repository/user_repository.dart';

class MobileView extends StatelessWidget {
  const MobileView({
    super.key,
    // required this.pushToTip,
    required this.userRepository,
    required this.onUnitSelected,
  });

  // final VoidCallback pushToTip;
  final UserRepository userRepository;
  final UnitSelected onUnitSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.mediumLarge),
      child: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(Spacing.xLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ProfileHeader(
                    userRepository: userRepository,
                  ),
                ),
                const SizedBox(
                  height: Spacing.large,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ProfileIdentity(
                    // pushToTip: pushToTip,
                    userRepository: userRepository,
                    isWider: false,
                    onUnitSelected: onUnitSelected,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
