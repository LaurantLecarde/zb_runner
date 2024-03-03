import 'package:flutter/cupertino.dart';

navigatePush(context,Widget to){
  Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>to));
}

navigatePop(context){
  Navigator.of(context).pop();
}

navigatePushAndRemove(context,Widget to){
  Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context)=>to), (route) => false);
}

