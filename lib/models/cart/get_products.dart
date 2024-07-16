import 'dart:convert';

List<CartItem> cartItemsFromJson(String str) => List<CartItem>.from(json.decode(str)['data'].map((x) => CartItem.fromJson(x)));

String cartItemsToJson(List<CartItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItem {
  String id;
  String userId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<ProductItem> cartItems; // Đổi tên trường thành 'cartItems'

  CartItem({
    required this.id,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.cartItems, // Đổi tên trường thành 'cartItems'
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"],
    userId: json["userId"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    cartItems: List<ProductItem>.from(json["cartItems"].map((x) => ProductItem.fromJson(x))), // Đổi tên trường thành 'cartItems'
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())), // Đổi tên trường thành 'cartItems'
  };
}

class ProductItem {
  String id;
  String cartId;
  String productId;
  int quantity;
  Product product;

  ProductItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
    id: json["id"],
    cartId: json["cartId"],
    productId: json["productId"],
    quantity: json["quantity"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cartId": cartId,
    "productId": productId,
    "quantity": quantity,
    "product": product.toJson(),
  };
}

class Product {
  String id;
  String category;
  String title;
  String name;
  String price;
  String oldPrice;
  String description;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<ImageUrl> imageUrl;

  Product({
    required this.id,
    required this.category,
    required this.title,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    category: json["category"],
    title: json["title"],
    name: json["name"],
    price: json["price"],
    oldPrice: json["oldPrice"],
    description: json["description"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    imageUrl: List<ImageUrl>.from(json["imageUrl"].map((x) => ImageUrl.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "title": title,
    "name": name,
    "price": price,
    "oldPrice": oldPrice,
    "description": description,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "imageUrl": List<dynamic>.from(imageUrl.map((x) => x.toJson())),
  };
}

class ImageUrl {
  String imageUrl;

  ImageUrl({
    required this.imageUrl,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
  };
}
