import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class OpenWebView extends StatefulWidget {
  final String url;
  final String title;
  
  const OpenWebView({Key key, @required this.url, @required this.title}) : super(key: key);

  @override
  _OpenWebViewState createState() => _OpenWebViewState();
}

class _OpenWebViewState extends State<OpenWebView> {

  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    FlutterWebviewPlugin().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title:Text(widget.title),
        centerTitle: true,
      ),
      hidden: true,
      withZoom: true,
      initialChild: Container(
        child: Center(
          child: CircularProgressIndicator(strokeWidth:1.5)
        ),
      ),
    );
  }
}