/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmaconnectbyturjo/Contains/HomeScreenController.dart';
//import 'package:pharmaconnectbyturjo/Contains/PersController.dart';
import 'package:pharmaconnectbyturjo/Contains/PopularProduct.dart';
import 'package:pharmaconnectbyturjo/Contains/PopularProductModel.dart';

class SearchPage extends SearchDelegate{
  PopularProductModel controller = Get.find();

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return[
      IconButton(onPressed: (){}, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    controller.searchProducts(query);

    return GetBuilder<HomeScreenController>(builder: (value) {
      if (!value.isSearchLoading) {
        return ListView.builder(
          itemCount: value.searchResults.length,
          itemBuilder: (context, index) {
            return listViewBuilderItems(Get.size, value.searchResults[index]);
          },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }



  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    controller.searchProducts(query);

    return GetBuilder<HomeScreenController>(builder: (value) {
      if (!value.isSearchLoading) {
        return ListView.builder(
          itemCount: value.searchResults.length,
          itemBuilder: (context, index) {
            return listViewBuilderItems(Get.size, value.searchResults[index]);
          },
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
  Widget listViewBuilderItems(Size size, PopularProductModel  model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        height: size.height / 8,
        width: size.width / 1.1,
        child: Row(
          children: [
            Container(
              height: size.height / 8,
              width: size.width / 4.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(model.product_image),
                ),
              ),
            ),
            SizedBox(
              width: size.width / 22,
            ),
            Expanded(
              child: SizedBox(
                child: RichText(
                  text: TextSpan(
                    text: "${model.product_name}\n",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [

                      TextSpan(
                        text: " ${model.product_price}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      // TextSpan(
                      //   text: " $discount% off",
                      //   style: const TextStyle(
                      //     fontSize: 15,
                      //     color: Colors.green,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }





}
*/
