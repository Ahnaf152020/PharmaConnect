class ProductsModel {
  late String product_name, product_image,product_description;
  late int product_price;

  ProductsModel({
    required this.product_name,
    required this.product_image,
    required this.product_price,
    required this.product_description,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    product_name = json['product_name'] ?? '';
    product_image = json['product_image']??'';
    product_price = json['product_price'] ?? '';
    product_description =json['product_description']?? '';
  }
}
