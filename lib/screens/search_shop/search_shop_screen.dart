
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/AllText.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/scoped_models/product_models.dart';

class SearchShopScreen extends StatefulWidget {
  const SearchShopScreen({key}) : super(key: key);

  @override
  State<SearchShopScreen> createState() => _SearchShopScreenState();
}

class _SearchShopScreenState extends State<SearchShopScreen> {
  FocusNode focusNode = FocusNode();
  ProductModel productModel;


  @override
  Widget build(BuildContext context) {
    if(productModel == null) {
      productModel = ProductModel();
    }
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: header(),
        backgroundColor: WHITE,
        leading: Container(),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: Container(
            height: 50,
            margin: EdgeInsets.all(10),
            child: TextField(
              focusNode: focusNode,
              decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  hintText: SEARCH_MEDICINE,
                  suffixIcon: IconButton(
                    icon: Image.asset(
                      "assets/homescreen/search_header.png",
                      height: 25,
                      width: 25,
                    ),
                    onPressed: () {
                      // searchMedicines(keyword);
                    },
                  )),
              onChanged: (val) {
                setState(() {
                  // keyword = val;
                });
                // searchMedicines(val);
              },
              onSubmitted: (val) {
                // searchMedicines(val);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ScopedModel<ProductModel>(
          model: productModel,
          child: Text("wassup"),
        ),
      ),
    );
  }
  header() {
    return SafeArea(
      child: Container(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: BLACK,
                    ),
                    constraints: BoxConstraints(maxWidth: 30, minWidth: 10),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    SEARCH,
                    style: TextStyle(
                        color: BLACK,
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  searchMedicines() {

  }

}
