import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PopularProduct extends StatefulWidget {
  const PopularProduct({Key? key}) : super(key: key);

  @override
  State<PopularProduct> createState() => _PopularProductState();
}

class _PopularProductState extends State<PopularProduct> {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  List<Map<String, dynamic>> popularProducts = [];

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot qn =
      await _firestoreInstance.collection("PopularProducts").get();
      setState(() {
        popularProducts = qn.docs.map((doc) {
          return {
            "product_name": doc["product_name"],
            //"product_description": doc["product_description"],
            "product_price": doc["product_price"],
            "product_image": doc["product_image"],
          };
        }).toList();
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 10.0,
        mainAxisExtent: 300,
      ),
      itemCount: popularProducts.length,
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            //color: const Color(0xFFFFECDF),
            border: Border.all(
              color: Color(0xFFFFECDF),
            ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFECDF), //New
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
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topRight,
                  //       end: Alignment.bottomLeft,
                  //       colors: [
                  //         Colors.blue,
                  //         Colors.red,
                  //       ],
                  //     ),),
                  child: Image.network(popularProducts[index]["product_image"]),
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
                    padding: const EdgeInsets.only(left: 10.0,right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${popularProducts[index]["product_name"]}",
                            style: Theme.of(context).textTheme.subtitle1!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "Price: ${popularProducts[index]['product_price']}৳",
                          style: Theme.of(context).textTheme.subtitle2!.merge(
                            TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_cart,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
