import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_gear_pro/models/cart/add_to_cart.dart';
import 'package:pet_gear_pro/models/cart/get_products.dart';
import 'package:pet_gear_pro/models/orders/orders_res.dart';
import 'package:pet_gear_pro/services/config.dart';

class CartHelper {
  static var client = http.Client();

  // Add to cart HELPER
  static Future<bool> addToCart(AddToCart model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Sử dụng header Authorization
    };

    var url = Uri.https(Config.apiUrl, Config.addCartUrl); // Sử dụng Uri.https
    var response = await client.post(url, headers: requestHeaders, body: jsonEncode(model.toJson()));
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // GET CART HELPER
  static Future<List<Product>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Sử dụng header Authorization
    };

    var url = Uri.https(Config.apiUrl, Config.getCartUrl); // Sử dụng Uri.https
    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Product> cart = [];

      var products = jsonData[0]['products'];
      cart = List<Product>.from(products.map((product) => Product.fromJson(product)));

      return cart;
    } else {
      throw Exception('Failed to get a cart');
    }
  }

  static Future<bool> deleteItem(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Sử dụng header Authorization
    };

    var url = Uri.https(Config.apiUrl, "${Config.addCartUrl}/$id"); // Sử dụng Uri.https
    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // GET ORDERS HELPER
  static Future<List<PaidOrders>> getOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Sử dụng header Authorization
    };

    var url = Uri.https(Config.apiUrl, Config.orders); // Sử dụng Uri.https
    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var products = paidOrdersFromJson(response.body);

      return products;
    } else {
      throw Exception('Failed to get orders');
    }
  }
}
