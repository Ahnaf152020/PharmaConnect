import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyOrderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (userSnapshot.hasData) {
            User? user = userSnapshot.data as User?;

            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .doc(user!.uid)
                  .collection('itemso')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, orderSnapshot) {
                if (orderSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final orderDocs = orderSnapshot.data as QuerySnapshot?;

                if (orderDocs == null || orderDocs.docs.isEmpty) {
                  return Center(child: Text('No orders found.'));
                }

                return ListView.builder(
                  itemCount: orderDocs.docs.length,
                  itemBuilder: (context, index) {
                    final orderData = orderDocs.docs[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(orderData['product_name']),
                      subtitle: Text('Quantity: ${orderData['quantity']}'),
                      trailing: Text('Total: ${orderData['total_amount']}৳'),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Please login to view orders.'));
          }
        },
      ),
    );
  }
}
