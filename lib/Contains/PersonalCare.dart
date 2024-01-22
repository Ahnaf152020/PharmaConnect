import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalCare extends StatefulWidget {
  const PersonalCare({Key? key}) : super(key: key);

  @override
  State<PersonalCare> createState() => _PersonalCaretState();
}

class _PersonalCaretState extends State<PersonalCare> {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _products = [];

  Future<void> fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("PersonalCare").get();
    setState(() {
      _products = qn.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Care'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 10.0,
                mainAxisExtent: 300,
              ),
              itemCount: _products.length,
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFFFECDF),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFFECDF),
                        blurRadius: 2.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xFFFFECDF),
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
                          child: Image.network(_products[index]["product_image"]),
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
                            padding: const EdgeInsets.only(left: 10.0, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${_products[index]["product_name"]}",
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
                                  "Price: ${_products[index]['product_price']}৳",
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
                                  CupertinoIcons.heart,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.shopping_cart,
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
            ),
          ],
        ),
      ),
    );
  }
}
