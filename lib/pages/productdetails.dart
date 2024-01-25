import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
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
              child: Image.network(productImage, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(
              'Product Name: $productName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Product Price: $productPrice৳',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              'Product Description: $productDescription',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement "Add to Cart" logic
                // You can add your cart logic here
                // For example, you might want to add the product to a shopping cart state
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
