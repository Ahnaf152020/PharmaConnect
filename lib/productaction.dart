import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductActions {
  static Future<void> addToCart({
    required String productName,
    required String productImage,
    required double productPrice,
    required String productDescription,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      await FirebaseFirestore.instance
          .collection('carts')
          .doc(userEmail)
          .collection('items')
          .add({
        'product_name': productName,
        'product_image': productImage,
        'product_price': productPrice,
        'product_description': productDescription,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(
        msg: 'Product added to cart',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,

      );
    }
  }

  static Future<void> addToFavorite({
    required String productName,
    required String productImage,
    required double productPrice,
    required String productDescription,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      await FirebaseFirestore.instance
          .collection('favourite')
          .doc(userEmail)
          .collection('items')
          .doc(productName)
          .set({
        'product_name': productName,
        'product_image': productImage,
        'product_price': productPrice,
        'product_description': productDescription,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(
        msg: 'Added to Favorites',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,

      );
    }
  }

  static Future<void> removeFromFavorite(String productName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userEmail = user.email!;

      await FirebaseFirestore.instance
          .collection('favourite')
          .doc(userEmail)
          .collection('items')
          .doc(productName)
          .delete();

      Fluttertoast.showToast(
        msg: 'Removed from Favorites',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,     );
    }
  }
}
