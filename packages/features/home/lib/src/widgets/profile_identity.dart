import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home/src/launch_url.dart';
import 'package:home/src/unit_selector.dart';
import 'package:user_repository/user_repository.dart';

class ProfileIdentity extends StatefulWidget {
  ProfileIdentity({
    super.key,
    @visibleForTesting LaunchUrl? launchUrl,
    required this.userRepository,
    required this.isWider,
    required this.onUnitSelected,
  }) : _launchUrl = LaunchUrl();

  final LaunchUrl _launchUrl;
  final UserRepository userRepository;
  final bool isWider;
  final UnitSelected onUnitSelected;

  @override
  State<ProfileIdentity> createState() => _ProfileIdentityState();
}

class _ProfileIdentityState extends State<ProfileIdentity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.separated(
          itemCount: widget.userRepository.socialList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                widget._launchUrl
                    .launch(widget.userRepository.socialList[index].url);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    widget.userRepository.getIconPath(
                        widget.userRepository.socialList[index].icon),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.userRepository.socialList[index].username,
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
          onTap: () {
            unitPrefDialog(context);
          },
        ),
      ],
    );
  }

  Future<dynamic> unitPrefDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: widget.isWider ? 0.4 : 0.8,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: persianBlue.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    child: Text(
                      'Choose a tip option',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        widget.onUnitSelected('btc');
                      },
                      child: Container(
                        height: 95,
                        width: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: ghost,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: persianBlue.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SvgPicture.asset(
                            'assets/bitcoin-circle.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        widget.onUnitSelected('sat');
                      },
                      child: Container(
                        height: 95,
                        width: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: ghost,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: persianBlue.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SvgPicture.asset(
                            'assets/satoshi-v1.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
