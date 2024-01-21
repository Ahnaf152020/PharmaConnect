class PopularProductModel {
  late String product_name, product_image;
  late int product_price;

  PopularProductModel({
    required this.product_name,
    required this.product_image,
    required this.product_price,
  });

  PopularProductModel.fromJson(Map<String, dynamic> map) {
    product_name = map['product_name'];
    product_image = map['product_image'];
    product_price = map['product_price'];
  }
}
