import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  Future<void> launch(String url) async {
    final urlToLaunch = Uri.parse(url);
    try {
      await launchUrl(urlToLaunch);
    } catch (error) {
      print('[!] [launch_url.dart | launch]: $error');
    }
  }
}
