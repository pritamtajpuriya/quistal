import 'package:flutter/material.dart';
import 'package:singleclinic/common/widgets/heading_tile.dart';
import 'package:singleclinic/modals/Doctor_model.dart';

class BrandsHorizontalSlider extends StatelessWidget {
  final List<Doctor> doctorList;
  const BrandsHorizontalSlider({Key key,this.doctorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadingTile(
          title: "Meet Our Doctors",
          route: "",
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [0,1,2,3]
                  .map(
                    (e) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "https://images-platform.99static.com/yLoEgG_50R5fqi0-nbz--cf5lOs=/265x0:1758x1493/500x500/top/smart/99designs-contests-attachments/109/109861/attachment_109861736",
                            width: 120,
                            height: 70,
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ),

      ],
    );
  }
}
