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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(widget.productImage, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(
              'Product Name: ${widget.productName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Product Price: ${widget.productPrice}৳',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              'Product Description: ${widget.productDescription}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
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
    );
  }
}
