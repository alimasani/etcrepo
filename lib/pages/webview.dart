import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class OpenWebView extends StatelessWidget {
  final String url;
  final String title;
  const OpenWebView({Key key, @required this.url, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title:Text(title)
      ),
    );
  }
}