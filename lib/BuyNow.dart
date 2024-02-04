import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuyNow extends StatefulWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  final int quantity;

  BuyNow({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.quantity,
  });

  @override
  _BuyNowState createState() => _BuyNowState();
}

class _BuyNowState extends State<BuyNow> {
  String userAddress = "";
  late String userName; // Declare user name
  late String userEmail; // Declare user email

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    double totalAmount = widget.productPrice * widget.quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            SizedBox(height: 8),
            Text(
              'Quantity: ${widget.quantity}',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 8),
            Text(
              'Total Amount: $totalAmount৳',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 16),
            Text(
              'User Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            user != null
                ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                var userData = snapshot.data as DocumentSnapshot;
                userName = userData['user name']; // Assign user name
                userEmail = userData['e-mail']; // Assign user email

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: $userName'),
                    Text('Email: $userEmail'),
                  ],
                );
              },
            )
                : Text('User not logged in'),

            SizedBox(height: 16),
            Text(
              'Product Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Image.network(widget.productImage, height: 100, width: 100),
            SizedBox(height: 16),
            Text(
              'Delivery Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  userAddress = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your delivery address',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (user != null) {
                  // Save the order details to Firestore
                  await FirebaseFirestore.instance
                      .collection('orders')
                      .doc(user.uid)
                      .collection('itemso')
                      .add({
                    'product_name': widget.productName,
                    'product_image': widget.productImage,
                    'product_price': widget.productPrice,
                    'quantity': widget.quantity,
                    'total_amount': totalAmount,
                    'user_address': userAddress,
                    'user name': userName, // Add user name
                    'e-mail': userEmail, // Add user email
                    'timestamp': FieldValue.serverTimestamp(),
                  });

                  // Display a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order placed successfully!'),
                    ),
                  );

                  // Navigate back to the product details page
                  Navigator.pop(context);
                }
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
