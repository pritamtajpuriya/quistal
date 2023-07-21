import 'package:flutter/material.dart';


class CircleWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  const CircleWidget({Key key,this.child,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color??Colors.white,
        borderRadius: BorderRadius.circular(100),
        
      ),
      child: ClipRRect(borderRadius:BorderRadius.circular(100),child: child),
    );
  }
}


