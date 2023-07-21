import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class HorizontalSimmerList extends StatelessWidget {
  const HorizontalSimmerList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,

            ),
            margin: EdgeInsets.all(8),
            width: 150.0,
            height: 30.0,
          ),
          itemCount: 10,
        ),
      ),

    );
  }
}
