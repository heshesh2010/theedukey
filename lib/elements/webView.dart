import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:theedukey/elements/topbar.dart';

import 'drawer.dart';

class WebView extends StatefulWidget {
  final String url;
  final String title;
  Function(dynamic value) onGet;
  WebView(this.url, this.title, {Key? key, required this.onGet})
      : super(key: key);

  @override
  _WebView createState() => _WebView();
}

class _WebView extends State<WebView> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: getTopBar(context, title: "school_details".tr, isback: true),
        drawer: DrawerSideMenu(),
        body: Column(children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey,
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  incognito: true,
                  clearCache: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {},
                onLoadStart: (InAppWebViewController controller, Uri? url) =>
                    print(
                  url.toString(),
                ),
                onLoadStop: (InAppWebViewController controller, Uri? url) {
                  controller.getHtml().then((value) => {
                        print(value),
                        if (value!.contains(
                            "<html><head></head><body>true</body></html>"))
                          widget.onGet(true)
                        else if (value.contains(
                            "<html><head></head><body>false</body></html>"))
                          widget.onGet(false)
                      });
                },
              ),
            ),
          ),
        ]));
  }
}
