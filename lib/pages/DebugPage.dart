// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../providers/global_provider.dart';
import '_AllPages.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({ super.key });

  @override
  State createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {

  _DebugPageState() {
      Utils.log('( DebugPage.dart ) init', 0 );
  }

  // (this page) variables
  static const String _fileName = 'DebugPage.dart';
  static String _logHTML = '';
  static const String kNavigationExamplePage = '''<!DOCTYPE html><html>
  <head><title>Navigation Delegate Example</title>
  <style>
          html,body {
            font-size: 55px;
        }
  </style>
  </head>
  <body>
  <p>
  The navigation delegate is set to block navigation to the youtube website.
  </p>
  <ul>
  <ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
  <ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
  </ul>
  </body>
  </html>
  ''';  
  late WebViewController _controller;
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));
    Utils.log('( $_fileName ) initState()');
  }

  @override
  void dispose() {
    Utils.log('( $_fileName ) dispose()');
    super.dispose();
  }

  // (this page) methods
  void _buildTriggered() {
    Utils.log('( $_fileName ) _buildTriggered()');
  }
  
  void _addPostFrameCallbackTriggered( context ) {
    Utils.log('( $_fileName ) _addPostFrameCallbackTriggered()');
  }

  // (this page) build
  @override
  Widget build(BuildContext context) {

    _buildTriggered();

    return WillPopScope(
      onWillPop: () async {
        Utils.log('( $_fileName ) WillPopScope() triggered');
        // context.read<Global>().incrementPop();
        return true;    // true allows back button (false denies)
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text( _fileName ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: <Widget>[
              Visibility(
                visible: Config.appDebugActive,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Utils.log('( $_fileName ) (event) clicked "close DebugPage()"');
                    Navigator.of(context).pop(); 
                  },
                ),
              )
            ],            
          ),
          body: Column(
            children: [
              Container(
                height: 60,
                width: double.infinity,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Utils.log('( $_fileName ) (event) clicked "Clear" button');
                        },
                        child: Text( 'Clear' ),
                        
                      ),
                    ],
                  ),
                )
              ),
              Expanded(
                flex :1,
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:                     WebView(
                    
                            initialUrl: 'about:blank',
                    
                            onWebViewCreated: (WebViewController webViewController) {
                    
                              _controller = webViewController;
                    
                              _loadHtmlFromAssets();
                    
                            },
                    
                          ),


                  )
                ),
              ),              
            ],
          ),
        ),
      ),
    );
  }

 _loadHtmlFromAssets() async {
    _logHTML = '<!DOCTYPE html><html><head><style> html,body { font-size: 35px; background-color: #fafafa; } hr { border-top: 2px solid #000; } td { padding: 2px 5px; vertical-align: top; } td.nowrap { white-space: nowrap; } </style></head><body><table>${Config.log}</table></body></html> ';
    String fileText = await rootBundle.loadString('assets/html/demo.html');
    _controller.loadUrl( Uri.dataFromString(
        //kNavigationExamplePage, //fileText,
        _logHTML,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
    
}