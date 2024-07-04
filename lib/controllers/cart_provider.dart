import 'package:flutter/foundation.dart';
import 'package:pet_gear_pro/models/cart/get_products.dart';

class CartProvider with ChangeNotifier {
  int _counter = 1;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter >= 1) {
      _counter--;
      notifyListeners();
    }
  }

  List<Product> checkOutList = [];

  List<Product> get getCheckOutList => checkOutList;

  set setCheckOut(Product newProduct) {
    // ignore: collection_methods_unrelated_type
    if (checkOutList.contains(newProduct.id)) {
      checkOutList.removeWhere((element) => element.id == newProduct.id);
    } else {
      checkOutList.add(newProduct);
    }

    notifyListeners();
  }
}
