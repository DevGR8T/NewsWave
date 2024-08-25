import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrendWebViewPage extends StatefulWidget {
  const TrendWebViewPage({super.key, required this.url});
  final String url;

  @override
  State<TrendWebViewPage> createState() => _TrendWebViewPageState();
}

class _TrendWebViewPageState extends State<TrendWebViewPage> {
  late WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController with desired settings
    _controller = WebViewController()
      // Allow unrestricted JavaScript execution
      ..setJavaScriptMode(JavaScriptMode.unrestricted)

      // Configure the navigation delegate to handle various events
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            // Set loading to true when a new page starts loading
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            // Set loading to false when page finishes loading
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError
              error) {}, // Handle any web resource loading errors here
          onNavigationRequest: (NavigationRequest request) {
            // Allow all navigation requests
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () async {
            // Check if WebView can go back, otherwise close the page
            if (await _controller.canGoBack()) {
              _controller.goBack();
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          children: [
            SizedBox(width: 60),
            Text(
              'News',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Wave',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // WebViewWidget to display the web content
          WebViewWidget(
            controller: _controller,
          ),
          // Show a loading indicator while the page is loading
          if (isLoading) LinearProgressIndicator(color: Colors.green),
        ],
      ),
    );
  }
}
