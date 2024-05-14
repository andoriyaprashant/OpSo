import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebviewScreen extends StatefulWidget {
  late String url;
  WebviewScreen(this.url);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState(url);
}

class _WebviewScreenState extends State<WebviewScreen> {

  late String url;
  _WebviewScreenState(this.url);
  WebViewController controller = WebViewController();

  void loadUrl(){
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        // if (request.url.startsWith('https://www.youtube.com/')) {
        //   return NavigationDecision.prevent;
        // }
        return NavigationDecision.navigate;
      },
    ));
    controller.loadRequest(Uri.parse(url));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      loadUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
