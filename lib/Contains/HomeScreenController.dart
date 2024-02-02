import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pharmaconnectbyturjo/Model/BabyCareModel.dart';
import 'package:pharmaconnectbyturjo/Model/DentalCareModel.dart';
import 'package:pharmaconnectbyturjo/Model/PopularProductModel.dart';
import 'package:pharmaconnectbyturjo/Model/SurgicalProductModel.dart';
import 'package:pharmaconnectbyturjo/Model/WomenCareModel.dart';

import '../toast.dart';

class HomeScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late List<PopularProductModel> popularProducts;
  late List<BabyCareModel> babyCare;
  late List<SurgicalProductModel> surgicalProduct;
  late List<WomenCareModel> WomenCare;
  late List<DentalCareModel> dentalcare;
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
      getAlLBabyCare(),
      getAllSurgicalProduct(),
      getAlLWomenCare(),
      getAllDentalCare()
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
  Future<void> getAlLWomenCare() async {
    await _firestore.collection('WomenCare').get().then((value) {
      WomenCare = value.docs
          .map((e) =>
          WomenCareModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }
  Future<void> getAllSurgicalProduct() async {
    await _firestore.collection('SurgicalProduct').get().then((value) {
      surgicalProduct = value.docs
          .map((e) =>
          SurgicalProductModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }
  Future<void> getAlLBabyCare() async {
    await _firestore.collection('BabyCare').get().then((value) {
      babyCare = value.docs
          .map((e) =>
          BabyCareModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> getAllDentalCare() async {
    await _firestore.collection('DentalCare').get().then((value) {
      dentalcare = value.docs
          .map((e) =>
          DentalCareModel.fromJson(e.data() as Map<String, dynamic>))
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

