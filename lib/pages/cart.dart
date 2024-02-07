import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmaconnectbyturjo/BuyNow.dart';
 // Import your BuyNow page

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _CartState();
}

class _CartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Cart Screen')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("carts")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Something is wrong"),);
              }

              return ListView.builder(
                itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                  String productImageURL = _documentSnapshot['product_image'];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuyNow(
                            productName: _documentSnapshot['product_name'],
                            productImage: productImageURL,
                            productPrice: _documentSnapshot['product_price'],
                            quantity: 1, // Set default quantity, you can change it as needed
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: 120,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: 120,
                              width: 50,
                              child: Image.network(
                                productImageURL,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _documentSnapshot['product_name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "\$ ${_documentSnapshot['product_price']}",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade700),
                              ),
                            ],
                          ),
                          trailing: GestureDetector(
                            child: CircleAvatar(child: Icon(Icons.remove_circle)),
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection('carts')
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection("items")
                                  .doc(_documentSnapshot.id)
                                  .delete();
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
