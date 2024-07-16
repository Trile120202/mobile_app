import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String userId;
  List<CartItemABC> cartItems;

  Order({
    required this.userId,
    required this.cartItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        userId: json["userId"],
        cartItems: List<CartItemABC>.from(json["cartItems"].map((x) => CartItemABC.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
      };
}

class CartItemABC {
  String name;
  String id;
  String price;
  int cartQuantity;

  CartItemABC({
    required this.name,
    required this.id,
    required this.price,
    required this.cartQuantity,
  });

  factory CartItemABC.fromJson(Map<String, dynamic> json) => CartItemABC(
        name: json["name"],
        id: json["id"],
        price: json["price"],
        cartQuantity: json["cartQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "price": price,
        "cartQuantity": cartQuantity,
      };
}
