import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmaconnectbyturjo/Contains/HomeScreenController.dart';
import 'package:pharmaconnectbyturjo/Model/PopularProductModel.dart';
import 'package:pharmaconnectbyturjo/pages/productdetails.dart';

class PopularProduct extends StatefulWidget {
  const PopularProduct({Key? key}) : super(key: key);

  @override
  State<PopularProduct> createState() => _PopularProductState();
}

class _PopularProductState extends State<PopularProduct> {
  List _PopularProducts = [];
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  fetchProducts() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("PopularProducts").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _PopularProducts.add({
          "product_name": qn.docs[i]["product_name"],
          "product_description": qn.docs[i]["product_description"],
          "product_price": (qn.docs[i]["product_price"] as num).toDouble(),
          "product_image": qn.docs[i]["product_image"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetBuilder<HomeScreenController>(
        builder: (value) {
          if (value.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<PopularProductModel> popularProducts = value.popularProducts;

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 30.0,
                mainAxisExtent: 300,
              ),
              itemCount: popularProducts.length,
              itemBuilder: (_, index) {
                PopularProductModel product = popularProducts[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetails(
                          productName: _PopularProducts[index]["product_name"],
                          productImage: _PopularProducts[index]["product_image"],
                          productPrice: (_PopularProducts[index]["product_price"] as num).toDouble(),
                          productDescription: _PopularProducts[index]["product_description"],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFFFECDF),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFAF7A).withOpacity(.8),
                          const Color(0xFFFFECDF).withOpacity(.0),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFECDF),
                          blurRadius: 2.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(16.0),
                      color: const Color(0xFFFFECDF),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            child: Image.network(product.product_image),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${product.product_name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .merge(
                                        const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(child: Text(
                                    "Price: ${product.product_price}৳",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .merge(
                                      TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
