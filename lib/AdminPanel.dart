import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final String adminEmail = 'admin@example.com';

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email != adminEmail) {
      // If the user is not logged in or is not an admin, show an error message.
      return Scaffold(
        appBar: AppBar(
          title: Text('Admin Panel'),
        ),
        body: Center(
          child: Text('You do not have permission to access this page.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collectionGroup('itemso').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No orders available.'),
            );
          }

          var orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index].data() as Map<String, dynamic>;
              var productName = order['product_name'];
              var productImage = order['product_image'];
              var productPrice = order['product_price'];
              var quantity = order['quantity'];
              var totalAmount = order['total_amount'];
              var userAddress = order['user_address'];
              var username = order['user name'];
              var useremail = order['e-mail'];

              return ListTile(
                title: Text('Product: $productName'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: $productPrice'),
                    Text('Quantity: $quantity'),
                    Text('Total Amount: $totalAmount'),
                    Text('User Address: $userAddress'),
                    Text('User Name: $username'),
                    Text('User Email: $useremail')
                    
                  ],
                ),
                leading: Image.network(productImage, height: 50, width: 50),
              );
            },
          );
        },
      ),
    );
  }
}
