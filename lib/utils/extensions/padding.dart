
import 'package:flutter/material.dart';

extension PaddingExt on Widget {
Widget p(int padding){
 return Container(
  padding: EdgeInsets.all(padding.toDouble()),
  child: this,
 );
}
Widget px(int padding){
 return Container(
  padding: EdgeInsets.symmetric(horizontal: padding.toDouble()),
  child: this,
 );
}

// ···
}