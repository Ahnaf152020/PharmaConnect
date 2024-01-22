import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pharmaconnectbyturjo/Contains/PopularProductModel.dart';

import '../toast.dart';

class HomeScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late List<PopularProductModel> popularProducts;

  List<PopularProductModel> searchResults = [];

  bool isSearchLoading = false;


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
  Future <void> searchProducts(String query) async {
    isSearchLoading = true;
    update();
    try {
      await
      _firestore.collection('PopularProducts')
          .where('product_name', isGreaterThanOrEqualTo: query)
          .get()
          .then((value) {
        searchResults =
            value.docs.map((e) => PopularProductModel.fromJson(e.data()))
                .toList();
        isSearchLoading = false;
        update();
      });
    } catch (e) {
      showToast(message: 'e');
    }
  }
}

