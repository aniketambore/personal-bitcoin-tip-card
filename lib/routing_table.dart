import 'package:btc_pay_repository/btc_pay_repository.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tip/tip.dart';
import 'package:user_repository/user_repository.dart';
import 'package:webview/webview.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required BTCPayRepository btcPayRepository,
  required UserRepository userRepository,
}) {
  return {
    _PathConstants.homePath: (_) => _buildMaterialPage(
          name: 'home-screen',
          child: HomeScreen(
            pushToTip: () => routerDelegate.push(_PathConstants.tipPath),
            userRepository: userRepository,
          ),
        ),
    _PathConstants.tipPath: (_) => _buildMaterialPage(
          name: 'tip-screen',
          child: TipScreen(
            btcPayRepository: btcPayRepository,
            userRepository: userRepository,
            onInvoiceCreateSuccess: (label, url, context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewScreen(label: label, url: url),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ),
  };
}

MaterialPage _buildMaterialPage({
  required String name,
  required Widget child,
}) {
  return MaterialPage(
    name: name,
    child: child,
  );
}

class _PathConstants {
  const _PathConstants._();

  static const String homePath = '/';
  static const String tipPath = '${homePath}tip';
}
