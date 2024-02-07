import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmaconnectbyturjo/Model/SurgicalProductModel.dart';
import 'package:pharmaconnectbyturjo/Contains/HomeScreenController.dart';
import 'package:pharmaconnectbyturjo/pages/productdetails.dart';

class SurgicalProduct extends StatefulWidget {
  const SurgicalProduct({Key? key}) : super(key: key);

  @override
  State<SurgicalProduct> createState() => _SurgicalProductState();
}

class _SurgicalProductState extends State<SurgicalProduct> {
  List _SurgicalProduct = [];
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  fetchProducts() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("SurgicalProduct").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _SurgicalProduct.add({
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

    return GetBuilder<HomeScreenController>(
      builder: (value) {
        if (value.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<SurgicalProductModel> SurgicalProducts =
              value.surgicalProduct;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Surgical Products'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 10.0,
                        mainAxisExtent: 300,
                      ),
                      itemCount: SurgicalProducts.length,
                      itemBuilder: (_, index) {
                        SurgicalProductModel product = SurgicalProducts[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetails(
                                  productName: _SurgicalProduct[index]["product_name"],
                                  productImage: _SurgicalProduct[index]["product_image"],
                                  productPrice: (_SurgicalProduct[index]["product_price"] as num).toDouble(),
                                  productDescription: _SurgicalProduct[index]["product_description"],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(16.0),
                                color: const Color(0xFFFFECDF),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
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
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
