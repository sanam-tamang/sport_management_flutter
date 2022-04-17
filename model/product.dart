class Product {
  String productID;
  String productName;
  String productColor;
  String productQuantity;
  String? productDescription;
  String date;

  Product({
    required this.productID,
    required this.productColor,
    required this.productName,
    required this.productQuantity,
    this.productDescription,
    required this.date,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productID: json['productID'],
        productName: json['productName'],
        productColor: json['productColor'],
        productQuantity: json['productQuantity'],
        productDescription: json['productDescription'],
        date: json['insertedDate']);
  }
}
