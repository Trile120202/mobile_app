import 'package:flutter/foundation.dart';
import 'package:pet_gear_pro/models/cart/get_products.dart';

class CartProvider with ChangeNotifier {
  // Quản lí số lượng cho từng sản phẩm
  Map<Product, int> _productQuantities = {};

  // Lấy số lượng sản phẩm
  int getQuantity(Product product) {
    return _productQuantities[product] ?? 1;
  }

  // Hàm tăng số lượng
  void incrementQuantity(Product product) {
    if (_productQuantities.containsKey(product)) {
      _productQuantities[product] = _productQuantities[product]! + 1;
    } else {
      _productQuantities[product] = 2;
    }
    notifyListeners();
  }

  // Clear giỏ hàng
  void clearCart() {
    _productQuantities.clear();
    _checkOutList.clear();
    notifyListeners();
  }

  // Hàm giảm số lượng
  void decrementQuantity(Product product) {
    if (_productQuantities.containsKey(product) && _productQuantities[product]! > 1) {
      _productQuantities[product] = _productQuantities[product]! - 1;
    } else {
      _productQuantities[product] = 1;
    }
    notifyListeners();
  }

  // Tính tổng giá
  double get totalPrice {
    double total = 0.0;
    _productQuantities.forEach((product, quantity) {
      total += double.parse(product.cartItem.price) * quantity;
    });
    return total;
  }

  // Danh sách sản phẩm để thanh toán
  List<Product> _checkOutList = [];

  List<Product> get getCheckOutList => _checkOutList;

  // Thêm hoặc xóa sản phẩm trong danh sách thanh toán
  void toggleCheckOutProduct(Product newProduct) {
    if (_checkOutList.any((element) => element.id == newProduct.id)) {
      _checkOutList.removeWhere((element) => element.id == newProduct.id);
    } else {
      _checkOutList.add(newProduct);
    }
    notifyListeners();
  }
}
