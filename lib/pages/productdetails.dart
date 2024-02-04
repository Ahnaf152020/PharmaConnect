import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatefulWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  final String productDescription;

  ProductDetails({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus(); // Check and set the initial favorite status
  }

  void checkFavoriteStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      // Check if the product is already in favorites
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('favourite')
          .doc(userEmail)
          .collection('items')
          .doc(widget.productName)
          .get();

      setState(() {
        isFavorite = snapshot.exists;
      });
    }
  }

  void addToCart() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      // Save product information to Firestore under the user's cart
      await FirebaseFirestore.instance
          .collection('carts')
          .doc(userEmail)
          .collection('items')
          .add({
        'product_name': widget.productName,
        'product_image': widget.productImage,
        'product_price': widget.productPrice,
        'product_description': widget.productDescription,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(
        msg: 'Product added to cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  void addtofavourite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      // Save product information to Firestore under the user's favorites
      await FirebaseFirestore.instance
          .collection('favourite')
          .doc(userEmail)
          .collection('items')
          .doc(widget.productName)
          .set({
        'product_name': widget.productName,
        'product_image': widget.productImage,
        'product_price': widget.productPrice,
        'product_description': widget.productDescription,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(
        msg: 'Added to Favorites',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      setState(() {
        isFavorite = true;
      });
    }
  }

  void removeFromFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      // Remove the product from favorites in Firestore
      await FirebaseFirestore.instance
          .collection('favourite')
          .doc(userEmail)
          .collection('items')
          .doc(widget.productName)
          .delete();

      Fluttertoast.showToast(
        msg: 'Removed from Favorites',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() {
        isFavorite = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Container(
                  height: 250,
                  child: Image.network(widget.productImage, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    spreadRadius: 0.0,
                    offset: Offset(
                      -2.0,
                      -2.0,
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.only(top: 25, right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Name: ${widget.productName}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Product Price: ${widget.productPrice}৳',
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 200, // Adjust the height as needed
                    child: ListView(
                      children: [
                        Text(
                          "${widget.productDescription}",
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .merge(const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: addToCart,
                          child: Text('Add to Cart'),
                        ),
                        IconButton(
                          onPressed: () {
                            if (isFavorite) {
                              removeFromFavorite();
                            } else {
                              addtofavourite();
                            }
                          },
                          icon: Icon(
                            isFavorite
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
