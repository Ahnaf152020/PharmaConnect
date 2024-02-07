import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmaconnectbyturjo/BuyNow.dart';

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
  int quantity = 1;

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
        'quantity': quantity,
        'total_amount': widget.productPrice * quantity,
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

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: 200,
                  child: Image.network(widget.productImage, fit: BoxFit.cover),
                ),
              ),
            ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Name: ${widget.productName}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Price: ${widget.productPrice}৳',
                        style: TextStyle(fontSize: 15, color: Colors.blue,fontStyle: FontStyle.italic),
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
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  // Adjust the height as needed
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      SizedBox(height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                      fontStyle: FontStyle.italic),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.black12,
                                      child: IconButton(
                                        iconSize: 20,
                                        onPressed: () => decrementQuantity(),
                                        icon: Icon(Icons.remove),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.black12,
                                      child: IconButton(
                                        iconSize: 20,
                                        onPressed: () => incrementQuantity(),
                                        icon: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: addToCart,
                                  child: Text('Add to Cart'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BuyNow(
                                          productName: widget.productName,
                                          productImage: widget.productImage,
                                          productPrice: widget.productPrice,
                                          quantity: quantity,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Buy Now'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
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
