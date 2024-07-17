import 'dart:convert';

List<PaidOrders> paidOrdersFromJson(String str) =>
    List<PaidOrders>.from(json.decode(str)["data"].map((x) => PaidOrders.fromJson(x)));

class PaidOrders {
  String id;
  double total;
  String deliveryStatus;
  String paymentStatus;
  int status;
  List<OrderItem> orderItems;

  PaidOrders({
    required this.id,
    required this.total,
    required this.deliveryStatus,
    required this.paymentStatus,
    required this.status,
    required this.orderItems,
  });

  factory PaidOrders.fromJson(Map<String, dynamic> json) => PaidOrders(
    id: json["id"],
    total: double.parse(json["total"]),
    deliveryStatus: json["deliveryStatus"],
    paymentStatus: json["paymentStatus"],
    status: json["status"],
    orderItems: List<OrderItem>.from(json["products"].map((x) => OrderItem.fromJson(x))),
  );
}

class OrderItem {
  String id;
  String name;
  double price;
  String description;
  int quantity;
  List<ImageUrl> imageUrl;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    required this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    name: json["name"],
    price: double.parse(json["price"]),
    description: json["description"],
    quantity: json["quantity"],
    imageUrl: List<ImageUrl>.from(json["imageUrl"].map((x) => ImageUrl.fromJson(x))),
  );
}

class ImageUrl {
  String id;
  String imageUrl;
  String productId;

  ImageUrl({
    required this.id,
    required this.imageUrl,
    required this.productId,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
    id: json["id"],
    imageUrl: json["imageUrl"],
    productId: json["productId"],
  );
}
