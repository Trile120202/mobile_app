import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  Products({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.oldPrice,
    required this.price,
    required this.description,
    required this.title,
  });
  final String id;
  final String name;
  final String category;
  final List<String> imageUrl;
  final String oldPrice;
  final String price;
  final String description;
  final String title;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        imageUrl: List<String>.from(json['imageUrl'].map((x) => x)),
        oldPrice: json["oldPrice"],
        price: json["price"],
        description: json['description'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "title": title,
        "category": category,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "oldPrice": oldPrice,
        "price": price,
        "description": description,
      };
}
