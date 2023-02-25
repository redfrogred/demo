// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../providers/global_provider.dart';
import '_AllPages.dart';
// import '../pages/_AllPages.dart';

class EndPage extends StatefulWidget {
  const EndPage({ super.key });

  @override
  State createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {

  _EndPageState() {
    Utils.log('<<< ( EndPage.dart ) init >>>', 0 );
  }

  // (this page) variables
  static const String _fileName = 'EndPage.dart';
  
  // (this page) init and dispose
  @override
  void initState() {
    super.initState();
    Utils.log('( $_fileName ) initState()');
    WidgetsBinding.instance.addPostFrameCallback((_) => _addPostFrameCallbackTriggered(context));
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
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                Utils.log('( $_fileName ) (event) clicked "go to StartPage()"');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => StartPage())
                );                
              },
              // start of button appearance settings 
              child: Text( 'Go to StartPage()' ),
      
            ),
          ),
        ),
      ),
    );
  }
}