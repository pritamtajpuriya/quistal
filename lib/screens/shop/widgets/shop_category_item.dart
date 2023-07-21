import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/category_model.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';
class ShopCategoryItem extends StatelessWidget {
  final Category category;
  final Function onTap;
  const ShopCategoryItem({Key key,this.category,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            child: ClipRRect(child: Image.network(getImageUrl(category.image),fit: BoxFit.cover,),borderRadius: BorderRadius.circular(100),),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)),
          ),
          SizedBox(height: 4,),
          Text(category.name,style:  GoogleFonts.poppins().copyWith(fontSize: 12),)
        ],
      ),
    );
  }
}
