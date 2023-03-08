import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'btc-pay-token', obfuscate: true)
  static final btcPayToken = _Env.btcPayToken;

  @EnviedField(varName: 'btc-pay-username', obfuscate: true)
  static final btcPayUsername = _Env.btcPayUsername;

  @EnviedField(varName: 'btc-pay-password', obfuscate: true)
  static final btcPayPassword = _Env.btcPayPassword;

  @EnviedField(varName: 'btc-pay-url', obfuscate: true)
  static final btcPayUrl = _Env.btcPayUrl;
}
