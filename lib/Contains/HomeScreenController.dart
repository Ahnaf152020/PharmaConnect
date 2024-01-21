import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pharmaconnectbyturjo/Contains/PopularProduct.dart';
import 'package:pharmaconnectbyturjo/Contains/PopularProductModel.dart';

class HomeScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late List<PopularProductModel> popularProducts;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getAllData();
  }

  void getAllData() async {
    await Future.wait([
      getAllPopularProducts(),
    ]).then((value) {
      //print("Data");
      //print(popularProducts[0].product_image);
      isLoading.value = false;
      update();
    });
  }

  Future<void> getAllPopularProducts() async {
    await _firestore.collection('PopularProducts').get().then((value) {
      popularProducts = value.docs
          .map((e) =>
          PopularProductModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
