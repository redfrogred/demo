// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import './Config.dart';

class Utils {

  // timestamp stuff
  static int beginTimeStamp = DateTime.now().millisecondsSinceEpoch;

  static int getBeginTimeStamp() {
    return beginTimeStamp;
  }

  static int timeStamp () {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String timeDiff () {
    int diff = timeStamp() - getBeginTimeStamp();
    double diffNum = 0;
    if (diff < 0) {
      diffNum = 0;
    }
    else {
      diffNum = diff * .001;
    }
    return '${diffNum.toStringAsFixed(1)} sec';
  }

  //  return a simplified version of Config.appVersion
  //  Example: "1.0.a.003" becomes "1.0"
  static String getSimpleVersion () {
    final splitted = Config.appVersion.split('.');
    // return splitted[0] + '.' + splitted[1];
    return Config.appVersion;
  }


  //  The "log" accepts 2 parameters, the 2nd is optional:
  //    1 - the String message to "log"
  //    2 - (optional) an int called "num" for "number of greater than signs" (2 is default)
  //
  //    If num is empty, it defaults to 2.
  //    If num is 0, the string will be highlighted (which just means it has a whack
  //    of equal signs before and after)

  static void log(String message, [ int num = 1 ]) {

    bool highlight = false;

    List<String> start = [
      '',         
      '>> ',    // num = 1    
      '>>> ',   // num = 2 
      '>>>> '   // num = 3    
    ];

    if ( num == 0 ) {
      highlight = true;
      num = 1;
    }

    // show highlighted?
    if ( highlight == true ) {
      if (kDebugMode) {
        print('${ start[num] } ====================================================');
      }
      Config.log += '<tr><td colspan="2"><hr /></td?</tr>';
    }

    // print the message
      if (kDebugMode) {
        print('${ start[num] } (${ timeDiff() }) $message');
      }
      Config.log += '<tr><td class="nowrap">(${ timeDiff() })</td><td>$message</td></tr>';

    // show highlighted?
    if ( highlight == true ) {
      if (kDebugMode) {
        print('${ start[num] } ====================================================');
      }
      Config.log += '<tr><td colspan="2"><hr /></td?</tr>';
    }


  }

  static void clearLog() {
    Config.log = '';
  }

}