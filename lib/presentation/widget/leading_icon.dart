import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/navigators.dart';

leadingIcon(context){
  return InkWell(
    onTap: ()=>navigatePop(context),
    child: Container(
      padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10)
        ),
        height: 30,
        width: 70,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.back,color: Colors.blue),
            Text("Back",style: TextStyle(color: Colors.blue))
          ],
        )),
  );
}