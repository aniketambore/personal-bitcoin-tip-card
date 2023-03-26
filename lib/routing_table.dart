import 'package:btc_pay_repository/btc_pay_repository.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:lnurl_invoice_screen/lnurl_invoice_screen.dart';
import 'package:lnurl_pay_repository/lnurl_pay_repository.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tip/tip.dart';
import 'package:user_repository/user_repository.dart';
import 'package:webview/webview.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required BTCPayRepository btcPayRepository,
  required LNURLPayRepository lnurlPayRepository,
  required UserRepository userRepository,
}) {
  return {
    _PathConstants.homePath: (_) => _buildMaterialPage(
          name: 'home-screen',
          child: HomeScreen(
            // pushToTip: () => routerDelegate.push(_PathConstants.tipPath),
            // pushToTip: () {},
            userRepository: userRepository,
            onUnitSelected: (selectedUnit) {
              final navigation = routerDelegate.push<String>(
                _PathConstants.tipPath(unit: "tip-$selectedUnit"),
              );
              return navigation.result;
            },
          ),
        ),
    // _PathConstants.tipPath: (_) => _buildMaterialPage(
    //       name: 'tip-screen',
    //       child: TipScreen(
    //         btcPayRepository: btcPayRepository,
    //         userRepository: userRepository,
    // onInvoiceCreateSuccess: (label, url, context) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => WebViewScreen(label: label, url: url),
    //       fullscreenDialog: true,
    //     ),
    //   );
    // },
    //       ),
    //     ),

    _PathConstants.tipPath(): (info) => MaterialPage(
        name: 'tip-screen',
        child: TipScreen(
          unitPreference:
              info.pathParameters[_PathConstants.unitParameter] ?? '',
          btcPayRepository: btcPayRepository,
          lnurlPayRepository: lnurlPayRepository,
          userRepository: userRepository,
          onBTCPayInvoiceCreatedSuccess: (label, url, context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(label: label, url: url),
                fullscreenDialog: true,
              ),
            );
          },
          onLNURLPayInvoiceCreatedSuccess:
              (invoice, lnurlPayRepository, context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LNURLInvoiceScreen(
                  bolt11Invoice: invoice,
                  lnurlPayRepository: lnurlPayRepository,
                ),
                fullscreenDialog: true,
              ),
            );
          },
        )),
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
  // static const String tipPath = '${homePath}tip';

  static String get unitParameter => 'unit';
  static String tipPath({
    String? unit,
  }) =>
      '$homePath${unit ?? ':$unitParameter'}';
}
