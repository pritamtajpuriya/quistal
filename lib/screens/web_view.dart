import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
// import 'package:flutter_webview_pro/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: WebView(
                key: _key,
                // javascriptMode: JavascriptMode.unrestricted,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: _url,
                // withJavascript: true,
                // url: _url,
                // withLocalStorage: true,

                //   initialUrl: _url,
                //   // withLocal
                //   onWebViewCreated: (controller) {
                //     controller.loadUrl(_url);
                //   },
                //
                //   javascriptMode: JavascriptMode.unrestricted,
                // ),
                //     WebviewScaffold(
                //   key: _key,
                //   withJavascript: true,
                //   url: _url,
                //   withLocalStorage: true,
                // )
              ),
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  print('go homescreen');
                },
                child: Text('CLOSE'),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
