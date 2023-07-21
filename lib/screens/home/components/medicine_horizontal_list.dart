import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/heading_tile.dart';
import 'package:singleclinic/common/widgets/horizontal_shimmer_list.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/scoped_models/product_models.dart';
import 'package:singleclinic/screens/product/product_details_screen.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/extensions/padding.dart';
import 'package:singleclinic/utils/helper.dart';

class MedicineHorizontalList extends StatelessWidget {
  final String title;
  final List<Hospital> medicineList;
  const MedicineHorizontalList({Key key, this.medicineList, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductModel>(
      model: ProductModel.instance,
      child: Builder(builder: (context) {
        ProductModel.of(context).getMedicinesList();
        return Column(
          children: [
            HeadingTile(
              title: title,
              route: ShopScreen.routeName,
            ),
            ScopedModelDescendant<ProductModel>(builder: (context, v, model) {
              return model.medicines.length > 0
                  ? SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: model.medicines
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => ProductDetailsScreen(
                                                product: e,
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            getImageUrl(e.photo),
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        e.name,
                                        style: GoogleFonts.poppins(),
                                      ),
                                      e.offeredprice == null
                                          ? Text(
                                              "Rs ${e.price.toString()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                  "Rs ${e.price.toString()}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      color: Colors.red),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Rs ${e.offeredprice.toString()}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ).p(8)
                  : HorizontalSimmerList();
            }),
          ],
        );
      }),
    );
  }
}
