import 'dart:convert';

String addToCartToJson(AddToCart data) => json.encode(data.toJson());

class AddToCart {
  final String cartItem;
  final int quantity;

  AddToCart({required this.cartItem, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'cartItem': cartItem,
      'quantity': quantity,
    };
  }
}
