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
        title: Text('Search Your Grocery'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0,left: 20.0),
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

                      var filteredProducts = snapshot.data!.docs
                          .where((document) =>
                          document['product_name']
                              .toString()
                              .toLowerCase()
                              .contains(inputText.toLowerCase()))
                          .toList();

                      return Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ListView(
                          children: filteredProducts
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                            return CustomProductCard(
                              productName: data['product_name'],
                              productImage: data['product_image'],
                            );
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

class CustomProductCard extends StatelessWidget {
  final String productName;
  final String productImage;

  CustomProductCard({required this.productName, required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(productName),
        leading: SizedBox(
          width: 50,
          child: Image.network(productImage),
        ),
        onTap: () {
          // Navigate to the ProductDetails screen when the card is tapped
        Navigator.pushNamed(context, 'productdetails');
        },
      ),
    );
  }
}
