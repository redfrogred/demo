// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../providers/global_provider.dart';
import '_AllPages.dart';
// import '../pages/_AllPages.dart';

class StartPage extends StatefulWidget {
  const StartPage({ super.key });

  @override
  State createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  _StartPageState() {
    if ( Config.appInitialized == false ) {
      Config.appInitialized = true;
      Utils.log('( StartPage.dart ) first init (version ${ Config.appVersion })', 0 );
    }
    else {
      Utils.log('( StartPage.dart ) init, again', 0 );
    }    
  }

  // (this page) variables
  static const String _fileName = 'StartPage.dart';
  
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
            centerTitle: true,
            actions: <Widget>[
              Visibility(
                visible: Config.appDebugActive,
                child: IconButton(
                  icon: Icon(
                    Icons.bug_report,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Utils.log('( $_fileName ) (event) clicked "go to DebugPage()"');
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => DebugPage())
                    ); 
                  },
                ),
              )
            ],            
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                Utils.log('( $_fileName ) (event) clicked "go to EndPage()"');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => EndPage())
                );                
              },
              // start of button appearance settings 
              child: Text( 'Go to EndPage()' ),
      
            ),
          ),
        ),
      ),
    );
  }
}