import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:home/src/unit_selector.dart';
import 'package:home/src/widgets/profile_header.dart';
import 'package:home/src/widgets/profile_identity.dart';
import 'package:user_repository/user_repository.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({
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
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: Center(
        child: ResponsiveBuilder(
          maxWidth: 768,
          maxHeight: 468,
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(Spacing.xLarge),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.mediumLarge,
                        ),
                        child: ProfileHeader(
                          userRepository: userRepository,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.mediumLarge,
                        ),
                        child: ProfileIdentity(
                          onUnitSelected: onUnitSelected,
                          userRepository: userRepository,
                          isWider: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
