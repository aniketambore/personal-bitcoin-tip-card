import 'package:domain_models/domain_models.dart';
import 'package:user_local_storage/user_local_storage.dart';
import 'package:user_repository/src/mappers/mappers.dart';

class UserRepository {
  UserRepository({
    required this.userLocalStorage,
  });

  final UserLocalStorage userLocalStorage;
  late final Identity identity;

  List<Social> get socialList => identity.socialList;

  static const Map<String, String> _iconPaths = {
    'twitter': 'assets/twitter.svg',
    'github': 'assets/github.svg',
    'linkedin': 'assets/linkedin.svg',
    'nostr': 'assets/nostr.svg',
  };

  Future<void> getUserIdentity() async {
    final identityLocal = await userLocalStorage.getUserIdentity();
    final identityDomain = identityLocal.toDomainModel();
    identity = identityDomain;
  }

  String getIconPath(String icon) {
    return _iconPaths.containsKey(icon.toLowerCase())
        ? _iconPaths[icon.toLowerCase()]!
        : 'assets/web.svg';
  }

  String _getValueOrDefault(String value, String defaultValue) {
    return (value.trim().isNotEmpty) ? value : defaultValue;
  }

  String get getUsername => _getValueOrDefault(identity.username, 'satoshi');

  String get getName => _getValueOrDefault(identity.name, 'Satoshi Nakamoto');

  String get getBio => _getValueOrDefault(identity.bio,
      'Bitcoin is a breakthrough in distributed computing and cryptography.');

  String get getLocation => _getValueOrDefault(identity.location, 'Mempool');

  String get getHireMeUrl =>
      _getValueOrDefault(identity.hireMeUrl, 'https://github.com/aniketambore');

  String get getImageUrl => _getValueOrDefault(
      identity.imageUrl, 'https://i.ibb.co/mJkxDkb/satoshi.png');

  String get getProjectUrl =>
      _getValueOrDefault(identity.projectUrl, 'https://github.com/aniket');

  String get getLud16 =>
      _getValueOrDefault(identity.lud16, 'aniketambore@getalby.com');
}
