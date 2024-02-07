import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmaconnectbyturjo/pages/Payment.dart';

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
  String selectedPaymentMethod = 'Online Payment'; // Default payment method

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    double totalAmount = widget.productPrice * widget.quantity;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Buy Now'),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.productName}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Product Price: ${widget.productPrice}৳',
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount: $totalAmount৳',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        'Quantity: ${widget.quantity}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Customer Information:',
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
                            userName =
                                userData['user name']; // Assign user name
                            userEmail = userData['e-mail']; // Assign user email

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(child: Text('Name: $userName')),
                                Center(child: Text('Email: $userEmail')),
                              ],
                            );
                          },
                        )
                      : Text('User not logged in'),
                  SizedBox(height: 16),
                  Text(
                    'Product Image',
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
                  Text(
                    'Payment Method:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedPaymentMethod,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPaymentMethod = newValue!;
                      });
                    },
                    items: <String>['COD', 'Online Payment']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              MaterialButton(
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
                      'payment_method':
                          selectedPaymentMethod, // Add payment method
                      'timestamp': FieldValue.serverTimestamp(),
                    });

                    // Display a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        //content: Text('Order placed successfully!'),
                        content: Center(child: Text('Saved Your Order')),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    if (selectedPaymentMethod == 'COD') {
                      // Navigate back to the homepage
                      Navigator.pop(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Payment(
                            productPrice: widget.productPrice,
                            quantity: widget.quantity,
                          ),
                        ),
                      );
                    }
                  }
                },
                height: 50,
                elevation: 30,
                splashColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.green[500],
                child: Center(
                    child: Container(
                  child: Text(
                    "Pay Now",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
