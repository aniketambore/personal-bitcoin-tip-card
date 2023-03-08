import 'package:btc_pay_api/btc_pay_api.dart';
import 'package:btc_pay_repository/btc_pay_repository.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:personal_bitcoin_tip_card/routing_table.dart';
import 'package:routemaster/routemaster.dart';
import 'package:user_local_storage/user_local_storage.dart';
import 'package:user_repository/user_repository.dart';
import 'env.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userRepository = await configureDependencies();
  usePathUrlStrategy();
  runApp(MainApp(
    userRepository: userRepository,
  ));
}

Future<UserRepository> configureDependencies() async {
  final userLocalStorage = UserLocalStorage(identityJson: 'identity.json');
  final userRepository = UserRepository(userLocalStorage: userLocalStorage);
  await userRepository.getUserIdentity();
  return userRepository;
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.userRepository,
  });
  final UserRepository userRepository;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final BTCPayApi _btcPayApi;
  late final BTCPayRepository _btcPayRepository;
  late final dynamic _routerDelegate;
  final _lightTheme = LightTipThemeData();
  final _darkTheme = DarkTipThemeData();

  @override
  void initState() {
    super.initState();
    _btcPayApi = BTCPayApi(
      url: Env.btcPayUrl,
      btcPayToken: Env.btcPayToken,
      btcPayUsername: Env.btcPayUsername,
      btcPayPassword: Env.btcPayPassword,
    );
    _btcPayRepository = BTCPayRepository(
      remoteApi: _btcPayApi,
    );
    _routerDelegate = RoutemasterDelegate(
      routesBuilder: (context) {
        return RouteMap(
          routes: buildRoutingTable(
            routerDelegate: _routerDelegate,
            btcPayRepository: _btcPayRepository,
            userRepository: widget.userRepository,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TipTheme(
      lightTheme: _lightTheme,
      darkTheme: _darkTheme,
      child: MaterialApp.router(
        title: 'Personal Bitcoin Tip Card',
        theme: _lightTheme.materialThemeData,
        darkTheme: _darkTheme.materialThemeData,
        themeMode: ThemeMode.light,
        routerDelegate: _routerDelegate,
        routeInformationParser: const RoutemasterParser(),
      ),
    );
  }
}
