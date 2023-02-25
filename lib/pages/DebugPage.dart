// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/Config.dart';
import '../classes/Utils.dart';
import '../providers/global_provider.dart';
import '_AllPages.dart';
// import '../pages/_AllPages.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({ super.key });

  @override
  State createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {

  _DebugPageState() {
      Utils.log('<<< ( DebugPage.dart ) init >>>', 0 );
  }

  // (this page) variables
  static const String _fileName = 'DebugPage.dart';
  
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Text( Config.log )),
                  )
                ),
              ),              
            ],
          ),
        ),
      ),
    );
  }
}