// SearchScreen
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/pages/productdetails.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Your items'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Column(
            children: [
              TextFormField(
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                    print(inputText);
                  });
                },
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Products")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Something went wrong"),
                        );
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }

                      /*var filteredProducts = snapshot.data!.docs
                          .where((document) =>
                          document['product_name']
                              .toString()
                              .toLowerCase()
                              .contains(inputText.toLowerCase()))
                          .toList();*/
                      var filteredProducts = snapshot.data!.docs
                          .where((document) =>
                      document['product_name']
                          .toString()
                          .toLowerCase()
                          .contains(inputText.toLowerCase()))
                          /*&&
                          document['product_price'] != null)*/
                          .toList();


                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ListView(
                          children: filteredProducts
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;



                            if (data['product_price'] != null && data['product_price'] is num) {
                              return CustomProductCard(
                                productName: data['product_name'],
                                productImage: data['product_image'],
                                productPrice: (data['product_price'] as num).toDouble(),
                                productDescription: data['product_description'] ?? '',
                              );}
                      else {
                              // Handle the case where 'product_price' is missing or not a valid number
                              print("Warning: 'product_price' field missing or invalid in document");
                              // You might want to return a placeholder or handle it differently
                              return CustomProductCard(
                                productName: data['product_name'],
                                productImage: data['product_image'],
                                productPrice: 0.0, // or any default value
                                productDescription: data['product_description'] ?? '',
                              );
                            }

                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CustomProductCard
class CustomProductCard extends StatelessWidget {
  final String productName;
  final String productImage;
  final double? productPrice; // Use double? to allow null
  final String productDescription;

  CustomProductCard({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ProductDetails screen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              productName: productName,
              productImage: productImage,
              productPrice: (productPrice ?? 0.0).toDouble(),
// Explicitly cast to double or provide a default value if null
              productDescription: productDescription,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Text(productName),
          subtitle: Text('Price: ${productPrice != null ? '\$${productPrice!.toStringAsFixed(2)}' : 'Price not available'}'),
          leading: SizedBox(
            width: 50,
            child: Image.network(productImage),


          ),
        ),
      ),
    );
  }
}