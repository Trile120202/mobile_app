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
  static Future<bool> addToCart(Map<String, dynamic> model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.https(Config.apiUrl, Config.addCartUrl);
    var response = await client.post(url, headers: requestHeaders, body: jsonEncode(model));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // GET CART HELPER
  static Future<List<ProductItem>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.https(Config.apiUrl, Config.getCartUrl);
    var response = await http.post(url, headers: requestHeaders);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      List<ProductItem> cart = [];
      var cartsData = jsonData['data'];
      for (var cartData in cartsData) {
        var cartItems = cartData['cartItems'];
        for (var cartItem in cartItems) {
          cart.add(ProductItem.fromJson(cartItem));
        }
      }
      return cart;
    } else {
      throw Exception('Failed to get a cart');
    }
  }

  static Future<bool> deleteItem(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var body = json.encode({
      "productId": id
    });

    print(id);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.https(Config.apiUrl, Config.deleteCartUrl);
    var response = await client.post(url, headers: requestHeaders, body: body);

    print(response.body);
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

    if (token == null) {
      throw Exception('Token is null');
    }
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.getOrders);
    var response = await http.post(url, headers: requestHeaders);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var products = paidOrdersFromJson(response.body);
      return products;
    } else if (response.statusCode == 401) {
      print('Error: Authentication failed. Please check the token and try again.');
      throw Exception('Authentication failed. Please check the token and try again.');
    } else {
      throw Exception('Failed to get orders: ${response.body}');
    }
  }

  static Future<bool> createOrders(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token is null');
    }
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.orders);
    var response = await http.post(url, headers: requestHeaders, body: jsonEncode(data));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 401) {
      // print(
      //     'Error: Authentication failed. Please check the token and try again.');
      // throw Exception(
      //     'Authentication failed. Please check the token and try again.');
      return false;
    } else {
      throw Exception('Failed to get orders: ${response.body}');
      return false;
    }
  }
}
