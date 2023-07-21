// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/screens/shop/widgets/shop_category_item.dart';
// import 'package:singleclinic/modals/category_model.dart';
// import 'package:singleclinic/modals/product_model.dart';
// import 'package:singleclinic/services/api_service.dart';

import '../../../scoped_models/product_models.dart';

class SearchMed extends StatefulWidget {
  const SearchMed({Key key}) : super(key: key);

  @override
  State<SearchMed> createState() => _SearchMedState();
}

class _SearchMedState extends State<SearchMed> {

 ProductModel productModel;

  @override
  initState() {
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
  }

  @override
  Widget build(BuildContext context) {
    if(productModel ==  null) {
      productModel = ProductModel();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Medicine and Tablets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ScopedModel<ProductModel>(
                model: ProductModel.instance, 
                child: Builder(
                  builder: (context) {
                    ProductModel.of(context).getProducts();
                    return ScopedModelDescendant<ProductModel>(
                      builder: (context, s_, model) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            // child: ShopCategoryItem(
                            //   category: model.categories[index],
                            //   onTap: () {
                            //     ProductModel.of(context).getProductsByCategory(
                            //         model.categories[index].id.toString());
                            //   },
                            // ),
                            child: Text(ProductModel.of(context).products[index].name),
                          ),
                          itemCount: ProductModel.of(context).products.length,
                        );
                        
                      }
                      );
                  }
                )
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}