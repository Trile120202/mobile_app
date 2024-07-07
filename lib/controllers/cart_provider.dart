import 'package:flutter/foundation.dart';
import 'package:pet_gear_pro/models/cart/get_products.dart';

class CartProvider with ChangeNotifier {
  //Quản lí cho đếm cho riêng từng sp
  Map<Product, int> _productQuantities = {};

  //Lấy số lượng sản phẩm
  int getQuantity(Product product) {
    return _productQuantities[product] ?? 1;
  }

  //Hàm tăng
  void incrementQuantity(Product product) {
    if (_productQuantities.containsKey(product)) {
      _productQuantities[product] = _productQuantities[product]! + 1;
    } else {
      _productQuantities[product] = 2;
    }
    notifyListeners();
  }

  //Hàm Giảm
  void decrementQuantity(Product product) {
    if (_productQuantities.containsKey(product) && _productQuantities[product]! > 1) {
      _productQuantities[product] = _productQuantities[product]! - 1;
    } else {
      _productQuantities[product] = 1;
    }
    notifyListeners();
  }

  //Tính Tổng
  double get totalPrice {
    double total = 0.0;
    _productQuantities.forEach((product, quantity) {
      total += double.parse(product.cartItem.price) * quantity;
    });
    return total;
  }

  List<Product> _checkOutList = [];

  List<Product> get getCheckOutList => _checkOutList;

  void toggleCheckOutProduct(Product newProduct) {
    if (_checkOutList.any((element) => element.id == newProduct.id)) {
      _checkOutList.removeWhere((element) => element.id == newProduct.id);
    } else {
      _checkOutList.add(newProduct);
    }
    notifyListeners();
  }
}
