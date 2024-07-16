class Config {
  static const apiUrl = "petshop-production-c5d0.up.railway.app";
  static const paymentBaseUrl = "paymentsever-production.up.railway.app";
  static const String loginUrl = "/auth/login";
  static const String paymentUrl = "/stripe/create-checkout-session";
  static const String signupUrl = "/auth/register";
  static const String getCartUrl = "/cart/get-cart";
  static const String addCartUrl = "/cart/add-cart-item";
  static const String deleteCartUrl = "/cart/delete-cart-item";
  static const String updateUserUrl = "/api/users/";
  static const String foods = "/product/list";
  static const String orders = "/order";
  static const String getOrders = "/order/get-order";
  static const String search = "/api/products/search/";
  static const String profile = "/auth/me";
  static const String updateprofile = "/auth/update";
  static const String UnSignin = "/product/get-list-product";
  static const String Favorite = "/product/favorite";
  static const String UnFavorite = "/product/unfavorite";
  static const String getFavorite = "/product/get-favorite";
}
