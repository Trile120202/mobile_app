import 'dart:convert';

String addToCartToJson(AddToCart data) => json.encode(data.toJson());

class AddToCart {
  final String productId;
  final int quantity;

  AddToCart({required this.productId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'cartItem': productId,
      'quantity': quantity,
    };
  }
}
