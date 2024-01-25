class WomenCareModel {
  late String product_name, product_image,product_description;
  late int product_price;

  WomenCareModel({
    required this.product_name,
    required this.product_image,
    required this.product_price,
    required this.product_description,
  });

  WomenCareModel.fromJson(Map<String, dynamic> map) {
    product_name = map['product_name'];
    product_image = map['product_image'];
    product_price = map['product_price'];
    product_description =map['product_description'];
  }
}
