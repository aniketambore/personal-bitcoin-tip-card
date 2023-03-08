import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    super.key,
    required this.label,
    required this.url,
  });

  final String label;
  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final PlatformWebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PlatformWebViewController(
        const PlatformWebViewControllerCreationParams())
      ..loadRequest(
        LoadRequestParams(
          uri: Uri.parse(
            widget.url,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
      ),
      body: PlatformWebViewWidget(
        PlatformWebViewWidgetCreationParams(
          controller: _controller,
        ),
      ).build(context),
    );
  }
}
