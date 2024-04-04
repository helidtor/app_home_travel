// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/screens/navigator_bar.dart';
import 'package:mobile_home_travel/screens/wallet/ui/wallet_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  String url;
  WebView({
    super.key,
    required this.url,
  });

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late String url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.endsWith('=SUCCESS')) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WalletScreen()),
              );
            } else if (request.url.endsWith('=FAILED')) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WalletScreen()),
              );
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return SafeArea(
      child: WebViewWidget(controller: controller),
    );
  }
}
